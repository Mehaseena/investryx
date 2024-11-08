import requests
import asyncio
from django.shortcuts import render
# from rest_framework.views import APIView
from adrf.views import APIView
from asgiref.sync import sync_to_async
from rest_framework.decorators import api_view
from rest_framework.response import Response
from django.contrib.auth.models import User
import random
from django.contrib.auth import authenticate
from .models import *
from .serializers import *
from django.utils import timezone
from django.contrib.auth import authenticate
from drf_yasg.utils import swagger_auto_schema
from drf_yasg import openapi
from django.db.models import Q
from dateutil.relativedelta import relativedelta
from django.core.files.base import ContentFile
from django.contrib.auth.hashers import check_password
from rest_framework.authtoken.models import Token
from rest_framework.authentication import TokenAuthentication
from django.db.models import Count, Sum
from django.db.models.functions import ExtractMonth
from django.core.cache import cache
from .utils.twilio_utils import *
from .utils.razorpay_utils import *
from .utils.async_serial_utils import *
from rest_framework import status
from datetime import timedelta
from smerg_chat.models import *
from django.db.models import Exists, OuterRef
from .utils.check_utils import * 

# Login
class LoginView(APIView):
    @swagger_auto_schema(operation_description="Login authentication using username and password, and return token",
    request_body=openapi.Schema(type=openapi.TYPE_OBJECT,required=['username', 'password'],
    properties={'username': openapi.Schema(type=openapi.TYPE_STRING, description='Username for authentication'),'password': openapi.Schema(type=openapi.TYPE_STRING, description='Password for authentication'),},),
    responses={200: '{"status": true,"token": "d08dcdfssd38ffaaa0d974fb7379e05ec1cd5b95"}',400:'{"status": false,"message": "Invalid credentials"}'})
    def post(self,request):
        if UserProfile.objects.filter(username=request.data.get('phone')).exists():
            user = UserProfile.objects.get(username=request.data.get('phone'))
            if check_password(request.data.get('password'), user.password):
                if not user.block:
                    token = Token.objects.get(user=user)
                    return Response({'status':True,'token':token.key})
                return Response({'status':False,'message': 'User Blocked'})
        return Response({'status':False,'message': 'Invalid credentials'})

# Social Implementation for verifying login
class Social(APIView):
    @swagger_auto_schema(operation_description="Verify if user is in DB using social media",request_body=openapi.Schema(type=openapi.TYPE_OBJECT,required=['username'],
    properties={'username': openapi.Schema(type=openapi.TYPE_STRING, description='Username/ Email for authentication'),},),
    responses={200: "{'status':True,'message': 'Verify if user is in DB using social media successfully'}",400:"Passes an error message"})
    def post(self,request):
        if UserProfile.objects.filter(email=request.data.get('username')).exists():
            user = UserProfile.objects.get(email=request.data.get('username'))
            token = Token.objects.get(user=user)
            return Response({'status':True,'token':token.key})
        return Response({'status':False,'message':'Register to continue'})

# Registration OTP
class RegisterOtp(APIView):
    @swagger_auto_schema(operation_description="Sending OTP for registration using whatsapp, twilio and phone number, and return a response",
    request_body=openapi.Schema(type=openapi.TYPE_OBJECT,required=['username','email'],
    properties={'username': openapi.Schema(type=openapi.TYPE_STRING, description='Username for authentication'),'email': openapi.Schema(type=openapi.TYPE_STRING, description='Email for authentication'),},),
    responses={200: "{'status':True}",400:"{'status':False,'message': 'User with same phone number/email id already exist'}"})
    def post(self,request):
        if request.data.get('phone') and request.data.get('email'):
            if UserProfile.objects.filter(Q(username=request.data.get('phone'))|Q(email=request.data.get('email'))).exists():
                return Response({'status':False,'message': 'User with same phone number/email id already exist'})
            otp = random.randint(1111,9999)
            key = f'otp_{request.data.get('phone')}'
            if not cache.get(key):
                cache.set(key, f"{otp:04d}", timeout=60)
            twilio_int(f"{otp:04d}", request.data.get('phone'))
            return Response({'status':True})
        return Response({'status':False,'message':"Phone number/ Email not found"})

# User registration
class RegisterView(APIView):
    @swagger_auto_schema(operation_description="User creation for an organisation",request_body=UserSerial,
    responses={200: "{'status':True,'message': 'User created successfully'}",400:"Passes an error message"})
    def post(self,request):
        key = f'otp_{request.data.get('phone')}'
        stored_otp = cache.get(key)
        print(stored_otp)
        if stored_otp:
            if int(stored_otp) == int(request.data.get('otp')):
                cache.delete(key)
                username = request.data.get('phone')
                email = request.data.get('email')
                name = request.data.get('name')
                password = request.data.get('password')
                if UserProfile.objects.filter(username=request.data.get('username')).exists():
                    return Response({'status':False,'message': 'User already exists'})
                request.data['username'] = request.data.get('phone')

                # Make random password for Social Login
                if password == "":
                    password = UserProfile.objects.make_random_password()
                    request.data['password'] = password
                serializer = UserSerial(data = request.data)
                if serializer.is_valid():
                    user = serializer.save()
                    token = Token.objects.create(user=user)
                    token.save()
                    user.set_password(request.data['password'])
                    user.first_name = name
                    user.save()

                    # Get image from URL (Google, Facebook)
                    if request.data.get('images') != None:
                        response = requests.get(request.data.get('images'))
                        if response.status_code == 200:
                            user.image.save(f'{user.username}_profile.jpg', ContentFile(response.content))
                    # gen.delete()
                    token = Token.objects.get(user=user)
                    return Response({'status':True,'token':token.key})
                return Response(serializer.errors)
            return Response({'status':False,'message': 'Incorrect OTP'})
        return Response({'status':False,'message': 'OTP has expired'})

# Forgot password
class ForgotPwd(APIView):
    @swagger_auto_schema(operation_description="Forgot password api, where an otp is sended to user's whatsapp",
    request_body=openapi.Schema(type=openapi.TYPE_OBJECT,required=['number'],
    properties={'number': openapi.Schema(type=openapi.TYPE_STRING, description='Phone number for authentication')}),
    responses={200: "{'status':True}",400:"{'status':False}"})
    def post(self,request):
        if UserProfile.objects.filter(username=request.data.get('number')).exists() and not UserProfile.objects.get(username=request.data.get('number')).block:
            otp = random.randint(0000,9999)
            key = f'otp_{request.data.get('phone')}'
            if not cache.get(key):
                cache.set(key, f"{otp:04d}", timeout=60)
            twilio_int(f"{otp:04d}", request.data.get('number'))
            return Response({'status':True})
        return Response({'status':False,'message': 'User doesnot exist'})

# Confirm OTP
class OTPConfirm(APIView):
    @swagger_auto_schema(operation_description="Confirm OTP api, where an otp is sended to user's whatsapp",
    request_body=openapi.Schema(type=openapi.TYPE_OBJECT,required=['phone'],
    properties={'phone': openapi.Schema(type=openapi.TYPE_STRING, description='Phone number for authentication')}),
    responses={200: "{'status':True}",400:"{'status':False}"})
    def post(self,request):
        if UserProfile.objects.filter(username=request.data.get('phone')).exists() and not UserProfile.objects.get(username=request.data.get('phone')).block:
            key = f'otp_{request.data.get('phone')}'
            stored_otp = cache.get(key)
            print(stored_otp)
            if stored_otp:
                if int(stored_otp) == int(request.data.get('otp')):
                    return Response({'status':True})
                return Response({'status':False,'message': 'Incorrect OTP'})
            return Response({'status':False,'message': 'OTP has expired'})
        return Response({'status':False,'message': 'User doesnot exist'})

# Change Password
class ChangePwd(APIView):
    @swagger_auto_schema(operation_description="Forgot password api, where an otp is sended to user's whatsapp",request_body=openapi.Schema(type=openapi.TYPE_OBJECT,required=['username'],
    properties={'username': openapi.Schema(type=openapi.TYPE_STRING, description='Username for authentication'),'password': openapi.Schema(type=openapi.TYPE_STRING, description='Password for authentication'),},),
    responses={200: "{'status':True,'message': 'User password changed successfully'}",400:"Passes an error message"})
    def post(self,request):
        password = request.data.get('password')
        if request.headers.get('token'):
            if UserProfile.objects.filter(auth_token=request.headers.get('token')).exists() and not UserProfile.objects.get(auth_token=request.headers.get('token')).block:
                user = UserProfile.objects.get(auth_token=request.headers.get('token'))
            else:
                return Response({'status':False,'message': 'User doesnot exist'})
        else:
            if not UserProfile.objects.get(username=request.data.get('username')).block:
                user = UserProfile.objects.get(username=request.data.get('username'))
        if check_password(password, user.password):
            return Response({'status':False})
        user.set_password(password)
        user.save()
        return Response({'status':True})

class Profiles(APIView):
    @swagger_auto_schema(
    operation_description="Fetch profiles based on the entity type (e.g., business, investor). " 
                          "You can specify the `show_all` parameter to retrieve all or "
                          "the logged-in user's profiles along with other profiles of a specified type.",
    manual_parameters=[openapi.Parameter('show_all', openapi.IN_QUERY, description="Set to 'true' to fetch all profiles of a specified type. Set to 'false' to fetch only the logged-in user's profiles and any other specified type.",type=openapi.TYPE_BOOLEAN,required=False,),
                       openapi.Parameter('type', openapi.IN_QUERY, description="The type of profile to fetch (e.g., 'advisor', 'business', 'investor'). Only relevant if `show_all` is 'false'.",type=openapi.TYPE_STRING,required=False,),
                       openapi.Parameter('token', openapi.IN_HEADER,description="Authentication token for the logged-in user.",type=openapi.TYPE_STRING,required=True,),],
    request_body=ProfileSerial,
    responses={
        200: openapi.Response("Success", ProfileSerial(many=True)),  
        400: "Error message if the request is malformed or required parameters are missing.",
        403: "User is blocked or authentication fails.",
        404: "User not found for the provided token."
    })

    def get(self,request):
        if request.headers.get('token'):
            if UserProfile.objects.filter(auth_token=request.headers.get('token')).exists() and not UserProfile.objects.get(auth_token=request.headers.get('token')).block:
                user = UserProfile.objects.get(auth_token=request.headers.get('token'))
                type=request.GET.get('type')
                show_all=request.GET.get('show_all', 'false').lower() == 'true'
                if show_all:
                    serializer = ProfileSerial(Profile.objects.filter(type=type).order_by('-id'), many=True)
                else:
                    serializer = ProfileSerial(Profile.objects.filter(user=user,type=type).order_by('-id').first())
                return Response(serializer.data)
            return Response({'status':False,'message': 'User doesnot exist'})
        return Response({'status':False,'message': 'Token is not passed'})

    @swagger_auto_schema(operation_description="create profiles",request_body=ProfileSerial,
    responses={200: "{'status':True,'message': 'created successfully'}",400:"Passes an error message"})
    def post(self, request):
        token = request.headers.get('token')
        if not token:
            return Response({'status': False, 'message': 'Token is not passed'}, status=status.HTTP_400_BAD_REQUEST)
        user = UserProfile.objects.filter(auth_token=token, block=False).first()
        if not user:
            return Response({'status': False, 'message': 'User does not exist or is blocked'}, status=status.HTTP_404_NOT_FOUND)
        plan_type = request.data.get('type')
        if not plan_type:
            return Response({'status': False, 'message': 'Plan type is required'}, status=status.HTTP_400_BAD_REQUEST)
        if Profile.objects.filter(user=user).exists():
            return Response({'status': False, 'message': 'User already has a profile'}, status=status.HTTP_400_BAD_REQUEST)
        subscription = Subscription.objects.filter(user=user, plan__type=plan_type).first()
        if not subscription:
            return Response({'status': False, 'message': 'Subscription with specified plan type does not exist'}, status=status.HTTP_404_NOT_FOUND)

        request.data['user'] = user.id  
        serializer = ProfileSerial(data=request.data) 

        if serializer.is_valid():
            serializer.save() 
            return Response({'status': True, 'message': 'Profile created successfully'}, status=status.HTTP_201_CREATED)
        
        return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)

    @swagger_auto_schema(operation_description="update user profiles",request_body=ProfileSerial,
    responses={200: "{'status':True,'message': 'updated successfully'}",400:"Passes an error message"})
    def patch(self,request,id):
        if request.headers.get('token'):
            if UserProfile.objects.filter(auth_token=request.headers.get('token')).exists() and not UserProfile.objects.get(auth_token=request.headers.get('token')).block:
                user = UserProfile.objects.get(auth_token=request.headers.get('token'))
                mutable_data = request.data.copy()
                profile = Profile.objects.get(id=id)
                serializer = ProfileSerial(profile, data=mutable_data, partial=True)
                if serializer.is_valid():
                    serializer.save()
                    return Response({'status':True})
                return Response(serializer.errors)
            return Response({'status':False,'message': 'User doesnot exist'})
        return Response({'status':False,'message': 'Token is not passed'})

    @swagger_auto_schema(operation_description="delete user profiles",request_body=ProfileSerial,
    responses={200: "{'status':True,'message': 'deleted successfully'}",400:"Passes an error message"})
    def delete(self,request,id):
        if request.headers.get('token'):
            if UserProfile.objects.filter(auth_token=request.headers.get('token')).exists() and not UserProfile.objects.get(auth_token=request.headers.get('token')).block:
                if id == 0:
                    investor = SaleProfiles.objects.filter(user__id=UserProfile.objects.get(auth_token=request.headers.get('token')).id,entity_type='investor')
                    investor.delete()
                    return Response({'status':True})
                investor = SaleProfiles.objects.get(id=id)
                investor.delete()
                return Response({'status':True})
            return Response({'status':False,'message': 'User doesnot exist'})
        return Response({'status':False,'message': 'Token is not passed'})

# Business
# Business
class BusinessList(APIView):
    @swagger_auto_schema(operation_description="Business post fetching",
    responses={200: "Business Details fetched succesfully",400:"Passes an error message"})
    def get(self, request, id):
        if request.headers.get('token'):
            if UserProfile.objects.filter(auth_token=request.headers.get('token')).exists() and not UserProfile.objects.get(auth_token=request.headers.get('token')).block:
                if id == 0:
                    serializer = SaleProfilesSerial(SaleProfiles.objects.filter(entity_type='business', block=False).order_by('-id'), many=True)
                else:
                    user = UserProfile.objects.get(auth_token=request.headers.get('token'))
                    serializer = SaleProfilesSerial(SaleProfiles.objects.filter(entity_type='business', user=user, block=False).order_by('-id'), many=True)
                return Response(serializer.data)
            return Response({'status':False,'message': 'User doesnot exist'})
        return Response({'status':False,'message': 'Token is not passed'})

    @swagger_auto_schema(
        operation_description="Business creation",
        request_body=SaleProfilesSerial, 
        responses={200: "{'status':True,'message': 'Business created successfully'}", 400: "{'name': ['This field is required.'], 'description': ['This field is required.'], 'image1': ['No file was submitted.'], 'doc1': ['No file was submitted.'], 'proof1': ['No file was submitted.']}"}
    )
    def post(self, request):
        token = request.headers.get('token')
        if not token:
            return Response({'status': False, 'message': 'Token is not passed'}, status=status.HTTP_400_BAD_REQUEST)

        # Fetch the user based on token
        user = UserProfile.objects.filter(auth_token=token, block=False).first()
        if not user:
            return Response({'status': False, 'message': 'User does not exist or is blocked'}, status=status.HTTP_404_NOT_FOUND)

        # Combine `data` and `FILES` for serializer
        # data = request.data.copy()
        request.data['user'] = user.id
        request.data['entity_type'] = 'business'

        # Initialize the serializer with both data and files
        serializer = SaleProfilesSerial(data=request.data)
        
        if not serializer.is_valid():
            return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)

        # Check subscription before saving
        subscription = Subscription.objects.filter(user=user, plan__type="business").first()
        if not subscription or subscription.remaining_posts == 0:
            return Response({'status': False, 'message': 'No valid subscription or remaining posts'}, status=status.HTTP_403_FORBIDDEN)

        # Save data if all checks pass
        serializer.save()
        subscription.remaining_posts -= 1
        subscription.save()
        return Response({'status': True, 'message': 'Business created successfully'}, status=status.HTTP_201_CREATED)

    @swagger_auto_schema(operation_description="Business post updation",request_body=SaleProfilesSerial,
    responses={200: "{'status':True,'message': 'Business updated successfully'}",400:"Passes an error message"})
    def patch(self,request,id):
        if request.headers.get('token'):
            if UserProfile.objects.filter(auth_token=request.headers.get('token')).exists() and not UserProfile.objects.get(auth_token=request.headers.get('token')).block:
                user = UserProfile.objects.get(auth_token=request.headers.get('token'))
                mutable_data = request.data.copy()
                business = SaleProfiles.objects.get(id=id)
                serializer = SaleProfilesSerial(business, data=mutable_data,partial=True)
                if serializer.is_valid():
                    serializer.save()
                    return Response({'status':True})
                return Response(serializer.errors)
            return Response({'status':False,'message': 'User doesnot exist'})
        return Response({'status':False,'message': 'Token is not passed'})

    @swagger_auto_schema(operation_description="Business account deletion",request_body=SaleProfilesSerial,
    responses={200: "{'status':True,'message': 'Business deleted successfully'}",400:"Passes an error message"})
    def delete(self,request,id):
        if request.headers.get('token'):
            if UserProfile.objects.filter(auth_token=request.headers.get('token')).exists() and not UserProfile.objects.get(auth_token=request.headers.get('token')).block:
                if id == 0:
                    business = SaleProfiles.objects.filter(user__id=UserProfile.objects.get(auth_token=request.headers.get('token')).id,entity_type='business')
                    business.delete()
                    return Response({'status':True})
                business = SaleProfiles.objects.get(id=id)
                business.delete()
                return Response({'status':True})
            return Response({'status':False,'message': 'User doesnot exist'})
        return Response({'status':False,'message': 'Token is not passed'})

# Investor
class InvestorList(APIView):
    @swagger_auto_schema(operation_description="Investor fetching",
    responses={200: "Investor Details fetched succesfully",400:"Passes an error message"})
    def get(self,request, id):
        if request.headers.get('token'):
            if UserProfile.objects.filter(auth_token=request.headers.get('token')).exists() and not UserProfile.objects.get(auth_token=request.headers.get('token')).block:
                if id == 0:
                    serializer = SaleProfilesSerial(SaleProfiles.objects.filter(entity_type='investor', block=False).order_by('-id'), many=True)
                else:
                    user = UserProfile.objects.get(auth_token=request.headers.get('token'))
                    serializer = SaleProfilesSerial(SaleProfiles.objects.filter(entity_type='investor', user=user, block=False).order_by('-id'), many=True)
                return Response(serializer.data)
            return Response({'status':False,'message': 'User doesnot exist'})
        return Response({'status':False,'message': 'Token is not passed'})

    @swagger_auto_schema(operation_description="Investor creation",request_body=SaleProfilesSerial,
    responses={200: "{'status':True,'message': 'Investor created successfully'}",400:"Passes an error message"})
    def post(self,request):
        token = request.headers.get('token')
        if not token:
            return Response({'status': False, 'message': 'Token is not passed'}, status=status.HTTP_400_BAD_REQUEST)

        # Fetch the user based on token
        user = UserProfile.objects.filter(auth_token=token, block=False).first()
        if not user:
            return Response({'status': False, 'message': 'User does not exist or is blocked'}, status=status.HTTP_404_NOT_FOUND)
        # data = request.data.copy()
        request.data['user'] = user.id
        request.data['entity_type'] = 'investor'

        serializer = SaleProfilesSerial(data=request.data)
        if not serializer.is_valid():
            return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)
        
        subscription = Subscription.objects.filter(user=user, plan__type="investor").first()
        if not subscription or subscription.remaining_posts == 0:
            return Response({'status': False, 'message': 'No valid subscription or remaining posts'}, status=status.HTTP_403_FORBIDDEN)

        # Save data if all checks pass
        serializer.save()
        subscription.remaining_posts -= 1
        subscription.save()
        return Response({'status': True, 'message': 'invest created successfully'}, status=status.HTTP_201_CREATED)

    @swagger_auto_schema(operation_description="Investor updation",request_body=SaleProfilesSerial,
    responses={200: "{'status':True,'message': 'Investor updated successfully'}",400:"Passes an error message"})
    def patch(self,request,id):
        if request.headers.get('token'):
            if UserProfile.objects.filter(auth_token=request.headers.get('token')).exists() and not UserProfile.objects.get(auth_token=request.headers.get('token')).block:
                user = UserProfile.objects.get(auth_token=request.headers.get('token'))
                mutable_data = request.data.copy()
                investor = SaleProfiles.objects.get(id=id)
                serializer = SaleProfilesSerial(investor, data=mutable_data, partial=True)
                if serializer.is_valid():
                    serializer.save()
                    return Response({'status':True})
                return Response(serializer.errors)
            return Response({'status':False,'message': 'User doesnot exist'})
        return Response({'status':False,'message': 'Token is not passed'})

    @swagger_auto_schema(operation_description="Investor deletion",request_body=SaleProfilesSerial,
    responses={200: "{'status':True,'message': 'Investor deleted successfully'}",400:"Passes an error message"})
    def delete(self,request,id):
        if request.headers.get('token'):
            if UserProfile.objects.filter(auth_token=request.headers.get('token')).exists() and not UserProfile.objects.get(auth_token=request.headers.get('token')).block:
                if id == 0:
                    investor = SaleProfiles.objects.filter(user__id=UserProfile.objects.get(auth_token=request.headers.get('token')).id,entity_type='investor')
                    investor.delete()
                    return Response({'status':True})
                investor = SaleProfiles.objects.get(id=id)
                investor.delete()
                return Response({'status':True})
            return Response({'status':False,'message': 'User doesnot exist'})
        return Response({'status':False,'message': 'Token is not passed'})

# Franchise
class FranchiseList(APIView):
    @swagger_auto_schema(operation_description="Franchise fetching",
    responses={200: "Franchise Details fetched succesfully",400:"Passes an error message"})
    def get(self,request, id):
        if request.headers.get('token'):
            if UserProfile.objects.filter(auth_token=request.headers.get('token')).exists() and not UserProfile.objects.get(auth_token=request.headers.get('token')).block:
                if id == 0:
                    serializer = SaleProfilesSerial(SaleProfiles.objects.filter(entity_type='franchise', block=False).order_by('-id'), many=True)
                else:
                    user = UserProfile.objects.get(auth_token=request.headers.get('token'))
                    serializer = SaleProfilesSerial(SaleProfiles.objects.filter(entity_type='franchise', user=user, block=False).order_by('-id'), many=True)
                return Response(serializer.data)
            return Response({'status':False,'message': 'User doesnot exist'})
        return Response({'status':False,'message': 'Token is not passed'})

    @swagger_auto_schema(operation_description="Franchise creation",request_body=SaleProfilesSerial,
    responses={200: "{'status':True,'message': 'Franchise created successfully'}",400:"Passes an error message"})
    def post(self,request):
        token = request.headers.get('token')
        if not token:
            return Response({'status': False, 'message': 'Token is not passed'}, status=status.HTTP_400_BAD_REQUEST)

        # Fetch the user based on token
        user = UserProfile.objects.filter(auth_token=token,block=False).first()
        if not user:
            return Response({'status': False, 'message':'User does not exist or is blocked'}, status=status.HTTP_404_NOT_FOUND)
        # data = request.data.copy()
        request.data['user'] = user.id
        request.data['entity_type'] = 'franchise'

        serializer = SaleProfilesSerial(data=request.data)
        if not serializer.is_valid():
            return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)
        
        subscription = Subscription.objects.filter(user=user, plan__type="franchise").first()
        if not subscription or subscription.remaining_posts == 0:
            return Response({'status': False, 'message': 'No valid subscription or remaining posts'}, status=status.HTTP_403_FORBIDDEN)

        # Save data if all checks pass
        serializer.save()
        subscription.remaining_posts -= 1
        subscription.save()
        return Response({'status': True, 'message': 'franchise created successfully'}, status=status.HTTP_201_CREATED)

    @swagger_auto_schema(operation_description="Franchise updation",request_body=SaleProfilesSerial,
    responses={200: "{'status':True,'message': 'Franchise updated successfully'}",400:"Passes an error message"})
    def patch(self,request,id):
        if request.headers.get('token'):
            if UserProfile.objects.filter(auth_token=request.headers.get('token')).exists() and not UserProfile.objects.get(auth_token=request.headers.get('token')).block:
                user = UserProfile.objects.get(auth_token=request.headers.get('token'))
                franchise = SaleProfiles.objects.get(id=id)
                serializer = SaleProfilesSerial(franchise, data=request.data,partial=True)
                if serializer.is_valid():
                    serializer.save()
                    return Response({'status':True})
                return Response(serializer.errors)
            return Response({'status':False,'message': 'User doesnot exist'})
        return Response({'status':False,'message': 'Token is not passed'})

    @swagger_auto_schema(operation_description="Franchise deletion",request_body=SaleProfilesSerial,
    responses={200: "{'status':True,'message': 'Franchise deleted successfully'}",400:"Passes an error message"})
    def delete(self,request,id):
        if request.headers.get('token'):
            if UserProfile.objects.filter(auth_token=request.headers.get('token')).exists() and not UserProfile.objects.get(auth_token=request.headers.get('token')).block:
                if id == 0:
                    franchise = SaleProfiles.objects.filter(user__id=UserProfile.objects.get(auth_token=request.headers.get('token')).id,entity_type='franchise')
                    franchise.delete()
                    return Response({'status':True})
                franchise = SaleProfiles.objects.get(id=id)
                franchise.delete()
                return Response({'status':True})
            return Response({'status':False,'message': 'User doesnot exist'})
        return Response({'status':False,'message': 'Token is not passed'})

# Advisor
# class AdvisorList(APIView):
#     @swagger_auto_schema(operation_description="Advisor fetching",
#     responses={200: "Advisor Details fetched succesfully",400:"Passes an error message"})
#     def get(self,request):
#         if request.headers.get('token'):
#             if UserProfile.objects.filter(auth_token=request.headers.get('token')).exists() and not UserProfile.objects.get(auth_token=request.headers.get('token')).block:
#                 id=request.GET.get('id')
#                 if id == 0:
#                     serializer = SaleProfilesSerial(SaleProfiles.objects.filter(entity_type='advisor', block=False).order_by('-id'), many=True)
#                 else:
#                     user = UserProfile.objects.get(auth_token=request.headers.get('token'))
#                     serializer = SaleProfilesSerial(SaleProfiles.objects.filter(entity_type='advisor', user=user, block=False).order_by('-id'), many=True)
#                 return Response(serializer.data)
#             return Response({'status':False,'message': 'User doesnot exist'})
#         return Response({'status':False,'message': 'Token is not passed'})

#     @swagger_auto_schema(operation_description="Advisor creation",request_body=SaleProfilesSerial,
#     responses={200: "{'status':True,'message': 'Advisor created successfully'}",400:"Passes an error message"})
#     def post(self,request):
#         if request.headers.get('token'):
#             if UserProfile.objects.filter(auth_token=request.headers.get('token')).exists() and not UserProfile.objects.get(auth_token=request.headers.get('token')).block:
#                 user = UserProfile.objects.get(auth_token=request.headers.get('token'))
#                 request.data['user'] = user.id
#                 request.data['entity_type'] = 'advisor'
#                 serializer = SaleProfilesSerial(data = request.data)
#                 if serializer.is_valid():
#                     if Subscription.objects.filter(user=user).exists() and Subscription.objects.get(user=user).remaining_posts != 0:
#                         serializer.save()
#                         return Response({'status':True})
#                     return Response({'status':False,'message': 'Subscription doesnot exist'})
#                 return Response(serializer.errors)
#             return Response({'status':False,'message': 'User doesnot exist'})
#         return Response({'status':False,'message': 'Token is not passed'})

#     @swagger_auto_schema(operation_description="Advisor updation",request_body=SaleProfilesSerial,
#     responses={200: "{'status':True,'message': 'Advisor updated successfully'}",400:"Passes an error message"})
#     def patch(self,request,id):
#         if request.headers.get('token'):
#             if UserProfile.objects.filter(auth_token=request.headers.get('token')).exists() and not UserProfile.objects.get(auth_token=request.headers.get('token')).block:
#                 user = UserProfile.objects.get(auth_token=request.headers.get('token'))
#                 advisor = SaleProfiles.objects.get(id=id)
#                 serializer = SaleProfilesSerial(advisor, data=request.data, partial=True)
#                 if serializer.is_valid():
#                     serializer.save()
#                     return Response({'status':True})
#                 return Response(serializer.errors)
#             return Response({'status':False,'message': 'User doesnot exist'})
#         return Response({'status':False,'message': 'Token is not passed'})

#     @swagger_auto_schema(operation_description="Advisor deletion",request_body=SaleProfilesSerial,
#     responses={200: "{'status':True,'message': 'Advisor deleted successfully'}",400:"Passes an error message"})
#     def delete(self,request,id):
#         if request.headers.get('token'):
#             if UserProfile.objects.filter(auth_token=request.headers.get('token')).exists() and not UserProfile.objects.get(auth_token=request.headers.get('token')).block:
#                 if id == 0:
#                     testimonial = Testimonial.objects.filter(user__id=UserProfile.objects.get(auth_token=request.headers.get('token')).id)
#                     advisor = SaleProfiles.objects.filter(user__id=UserProfile.objects.get(auth_token=request.headers.get('token')).id,entity_type='advisor')
#                     testimonial.delete()
#                     advisor.delete()
#                     return Response({'status':True})
#                 advisor = SaleProfiles.objects.get(id=id)
#                 testimonial = Testimonial.objects.filter(user=advisor.user)
#                 testimonial.delete()
#                 advisor.delete()
#                 return Response({'status':True})
#             return Response({'status':False,'message': 'User doesnot exist'})
#         return Response({'status':False,'message': 'Token is not passed'})

# User information
class UserView(APIView):
    @swagger_auto_schema(operation_description="User fetching",
    responses={200: "User Details fetched succesfully",400:"Passes an error message"})
    def get(self,request):
        if request.headers.get('token'):
            if UserProfile.objects.filter(auth_token=request.headers.get('token')).exists() and not UserProfile.objects.get(auth_token=request.headers.get('token')).block:
                user = UserProfile.objects.get(auth_token=request.headers.get('token'))
                user_serializer = UserSerial(user)
                return Response(user_serializer.data)
            return Response({'status':False,'message': 'User doesnot exist'})
        return Response({'status':False,'message': 'Token is not passed'})

    @swagger_auto_schema(operation_description="User updation",request_body=UserProfile,
    responses={200: "{'status':True,'message': 'User updated successfully'}",400:"Passes an error message"})
    def put(self,request):
        if request.headers.get('token'):
            if UserProfile.objects.filter(auth_token=request.headers.get('token')).exists() and not UserProfile.objects.get(auth_token=request.headers.get('token')).block:
                user = UserProfile.objects.get(auth_token=request.headers.get('token'))
                if UserProfile.objects.filter(Q(username=request.data.get('phone'))|Q(email=request.data.get('email'))& ~Q(id=user.id)).exists():
                    return Response({'status':False,'message': 'User with same details already exists'})
                mutable_data = request.data.copy()
                mutable_data['password'] = user.password
                serializer = UserSerial(user,data = mutable_data)
                if serializer.is_valid():
                    serializer.save()
                    return Response({'status':True,'message': 'User updated successfully'})
                return Response(serializer.errors)
            return Response({'status':False,'message': 'User doesnot exist'})
        return Response({'status':False,'message': 'Token is not passed'})

    @swagger_auto_schema(operation_description="User deletion",request_body=UserSerial,
    responses={200: "{'status':True,'message': 'User deleted successfully'}",400:"Passes an error message"})
    def delete(self,request):
        if request.headers.get('token'):
            if UserProfile.objects.filter(auth_token=request.headers.get('token')).exists() and not UserProfile.objects.get(auth_token=request.headers.get('token')).block:
                user = UserProfile.objects.get(auth_token=request.headers.get('token')).delete()
                return Response({'status':True})
            return Response({'status':False,'message': 'User doesnot exist'})
        return Response({'status':False,'message': 'Token is not passed'})

# Search based on query and filtering
class Search(APIView):
    @swagger_auto_schema(operation_description="Search query fetching",
    responses={200: "Search query details fetched succesfully",400:"Passes an error message"})
    def get(self,request):
        if request.headers.get('token'):
            if UserProfile.objects.filter(auth_token=request.headers.get('token')).exists() and not UserProfile.objects.get(auth_token=request.headers.get('token')).block:
                if request.GET.get('filter') == "false":
                    search = SaleProfiles.objects.filter(Q(name__icontains=request.GET.get('query')) | Q(company__icontains=request.GET.get('query')))
                else:
                    query = Q()
                    query = Q(name__icontains=request.GET.get('query')) | Q(company__icontains=request.GET.get('query'))
                    if request.GET.get('city'):
                        query &= Q(city__icontains=request.GET.get('city'))
                    if request.GET.get('state'):
                        query &= Q(state__icontains=request.GET.get('state'))
                    if request.GET.get('industry'):
                        intustry_list = request.GET.get('industry') if isinstance(request.GET.get('industry'), list) else [request.GET.get('industry')]
                        query &= Q(industry__in=intustry_list)
                    if request.GET.get('entity_type'): 
                        entity_type_list = request.GET.get('entity_type') if isinstance(request.GET.get('entity_type'), list) else [request.GET.get('entity_type')]
                        query &= Q(entity_type__in=entity_type_list)
                    if request.GET.get('establish_from') and request.GET.get('establish_to'):
                        query &= Q(establish_yr__range=[request.GET.get('establish_from'),request.GET.get('establish_to')])
                    if request.GET.get('range_starting'):
                        query &= Q(range_starting__gte=float(request.GET.get('range_starting')))
                    if request.GET.get('range_ending'):
                        query &= Q(range_ending__lte=float(request.GET.get('range_ending')))
                    search = SaleProfiles.objects.filter(query)
                serializer = SaleProfilesSerial(search, many=True)
                return Response({'status':True,'data':serializer.data})
            return Response({'status':False,'message': 'User doesnot exist'})
        return Response({'status':False,'message': 'Token is not passed'})

# Wishlist
class Wishlists(APIView):
    @swagger_auto_schema(operation_description="Wishlist fetching",
    responses={200: "Wishlist Details fetched succesfully",400:"Passes an error message"})
    def get(self,request):
        if request.headers.get('token'):
            if UserProfile.objects.filter(auth_token=request.headers.get('token')).exists() and not UserProfile.objects.get(auth_token=request.headers.get('token')).block:
                user = UserProfile.objects.get(auth_token=request.headers.get('token'))
                data = []
                for i in Wishlist.objects.filter(user=user).order_by('-id'):
                    serializer = SaleProfilesSerial(SaleProfiles.objects.get(id=i.product.id))
                    data.append(serializer.data)
                return Response(data)
            return Response({'status':False,'message': 'User doesnot exist'})
        return Response({'status':False,'message': 'Token is not passed'})

    @swagger_auto_schema(operation_description="Wishlist creation",request_body=SaleProfilesSerial,
    responses={200: "{'status':True,'message': 'Wishlist created successfully'}",400:"{'status':False,'error':'Already exists in wishlist'}"})
    def post(self,request):
        if request.headers.get('token'):
            if UserProfile.objects.filter(auth_token=request.headers.get('token')).exists() and not UserProfile.objects.get(auth_token=request.headers.get('token')).block:
                user = UserProfile.objects.get(auth_token=request.headers.get('token'))
                request.data['user'] = user.id
                product = SaleProfiles.objects.get(id=request.data.get('productId'))
                request.data['product'] = request.data.get('productId')
                if Wishlist.objects.filter(user=user,product=product).exists():
                    return Response({'status':False,'error':'Already exists in wishlist'})
                serializer = WishlistSerial(data = request.data)
                if serializer.is_valid():
                    serializer.save()
                    return Response({'status':True})
                return Response(serializer.errors)
            return Response({'status':False,'message': 'User doesnot exist'})
        return Response({'status':False,'message': 'Token is not passed'})

    @swagger_auto_schema(operation_description="Wishlist deletion",request_body=SaleProfilesSerial,
    responses={200: "{'status':True,'message': 'Wishlist deleted successfully'}",400:"Passes an error message"})
    def delete(self,request):
        if request.headers.get('token'):
            if UserProfile.objects.filter(auth_token=request.headers.get('token')).exists() and not UserProfile.objects.get(auth_token=request.headers.get('token')).block:
                user = UserProfile.objects.get(auth_token=request.headers.get('token'))
                pid = request.GET.get('productId')
                serializer = Wishlist.objects.get(user=user,product__id=pid)
                serializer.delete()
                return Response({'status':True})
            return Response({'status':False,'message': 'User doesnot exist'})
        return Response({'status':False,'message': 'Token is not passed'})

# Recent Activities
class RecentActs(APIView):
    @swagger_auto_schema(operation_description="Recent Activity fetching",
    responses={200: "Recent Activity Details fetched succesfully",400:"Passes an error message"})
    def get(self,request):
        if request.headers.get('token'):
            if UserProfile.objects.filter(auth_token=request.headers.get('token')).exists() and not UserProfile.objects.get(auth_token=request.headers.get('token')).block:
                user = UserProfile.objects.get(auth_token=request.headers.get('token'))
                data = []
                for i in RecentActivity.objects.filter(user=user).order_by('-id'):
                    serializer = SaleProfilesSerial(SaleProfiles.objects.get(id=i.product.id))
                    data.append(serializer.data)
                return Response(data)
            return Response({'status':False,'message': 'User doesnot exist'})
        return Response({'status':False,'message': 'Token is not passed'})

    @swagger_auto_schema(operation_description="Recent Activity creation",request_body=RecentSerial,
    responses={200: "{'status':True,'message': 'Recent Activity created successfully'}",400:"Passes an error message"})
    def post(self,request):
        if request.headers.get('token'):
            if UserProfile.objects.filter(auth_token=request.headers.get('token')).exists() and not UserProfile.objects.get(auth_token=request.headers.get('token')).block:
                user = UserProfile.objects.get(auth_token=request.headers.get('token'))
                request.data['user'] = user.id
                product = SaleProfiles.objects.get(id=request.data.get('productId'))
                if product.entity_type == "Advisor":
                    return Response({'status':False,'message': 'Advisor cant add'})
                request.data['product'] = request.data.get('productId')

                ## Deleting and updating to front if the data is already in DB
                if RecentActivity.objects.filter(user=user,product=product).exists():
                    recent = RecentActivity.objects.filter(user=user,product=product).delete()
                serializer = RecentSerial(data = request.data)
                if serializer.is_valid():
                    serializer.save()
                    return Response({'status':True})
                return Response(serializer.errors)
            return Response({'status':False,'message': 'User doesnot exist'})
        return Response({'status':False,'message': 'Token is not passed'})

# Suggestions
class Suggests(APIView):
    @swagger_auto_schema(operation_description="Suggestion creation",request_body=SuggestSerial,
    responses={200: "{'status':True,'message': 'Suggestion created successfully'}",400:"Passes an error message"})
    def post(self,request):
        if request.headers.get('token'):
            if UserProfile.objects.filter(auth_token=request.headers.get('token')).exists() and not UserProfile.objects.get(auth_token=request.headers.get('token')).block:
                user = UserProfile.objects.get(auth_token=request.headers.get('token'))
                request.data['user'] = user.id
                serializer = SuggestSerial(data = request.data)
                if serializer.is_valid():
                    serializer.save()
                    return Response({'status':True})
                return Response(serializer.errors)
            return Response({'status':False,'message': 'User doesnot exist'})
        return Response({'status':False,'message': 'Token is not passed'})

# Testimonials
class Testimonials(APIView):
    @swagger_auto_schema(operation_description="Testimonial fetching",
    responses={200: "Testimonial Details fetched succesfully",400:"Passes an error message"})
    def get(self,request):
        if request.headers.get('token'):
            if UserProfile.objects.filter(auth_token=request.headers.get('token')).exists() and not UserProfile.objects.get(auth_token=request.headers.get('token')).block:
                if request.GET.get('userId'):
                    user = UserProfile.objects.get(id=request.GET.get('userId'))
                    serializer = TestSerial(Testimonial.objects.filter(user=user).order_by('-id'), many=True)
                    return Response(serializer.data)
                user = UserProfile.objects.get(auth_token=request.headers.get('token'))
                serializer = TestSerial(Testimonial.objects.filter(user=user).order_by('-id'), many=True)
                return Response(serializer.data)
            return Response({'status':False,'message': 'User doesnot exist'})
        return Response({'status':False,'message': 'Token is not passed'})

    @swagger_auto_schema(operation_description="Testimonial creation",request_body=TestSerial,
    responses={200: "{'status':True,'message': 'Testimonial created successfully'}",400:"Passes an error message"})
    def post(self,request):
        if request.headers.get('token'):
            if UserProfile.objects.filter(auth_token=request.headers.get('token')).exists() and not UserProfile.objects.get(auth_token=request.headers.get('token')).block:
                user = UserProfile.objects.get(auth_token=request.headers.get('token'))
                request.data['user'] = user.id
                serializer = TestSerial(data = request.data)
                if serializer.is_valid():
                    serializer.save()
                    return Response({'status':True})
                return Response(serializer.errors)
            return Response({'status':False,'message': 'User doesnot exist'})
        return Response({'status':False,'message': 'Token is not passed'})

    @swagger_auto_schema(operation_description="Testimonial deletion",request_body=TestSerial,
    responses={200: "{'status':True,'message': 'Testimonial deleted successfully'}",400:"Passes an error message"})
    def delete(self,request,id):
        if request.headers.get('token'):
            if UserProfile.objects.filter(auth_token=request.headers.get('token')).exists() and not UserProfile.objects.get(auth_token=request.headers.get('token')).block:
                test = Testimonial.objects.get(id=id)
                test.delete()
                return Response({'status':True})
            return Response({'status':False,'message': 'User doesnot exist'})
        return Response({'status':False,'message': 'Token is not passed'})

# Recent Transactions
class Transactions(APIView):
    @swagger_auto_schema(operation_description="Transactions (Recent Updations) fetching",
    responses={200: "Transaction Details fetched succesfully",400:"Passes an error message"})
    def get(self,request):
        if request.headers.get('token'):
            if UserProfile.objects.filter(auth_token=request.headers.get('token')).exists() and not UserProfile.objects.get(auth_token=request.headers.get('token')).block:
                serializer = TransSerial(ActivityLog.objects.all().order_by('-id')[:10], many=True)
                return Response(serializer.data)
            return Response({'status':False,'message': 'User doesnot exist'})
        return Response({'status':False,'message': 'Token is not passed'})

# Preferences
class Prefer(APIView):
    @swagger_auto_schema(operation_description="Preference details creation",request_body=PrefSerial,
    responses={200: "{'status':True,'message': 'Preference details created successfully'}",400:"Passes an error message"})
    def post(self,request):
        if request.headers.get('token'):
            if UserProfile.objects.filter(auth_token=request.headers.get('token')).exists():
                user = UserProfile.objects.get(auth_token=request.headers.get('token'))
                if Preference.objects.filter(user=user).exists():
                    return Response({'status':True,'message': 'Preference already exist'})
                request.data['user'] = user.id
                serializer = PrefSerial(data = request.data)
                if serializer.is_valid():
                    serializer.save()
                    return Response({'status':True})
                return Response(serializer.errors)
            return Response({'status':False,'message': 'User doesnot exist'})
        return Response({'status':False,'message': 'Token is not passed'})

# Recommended Posts
class Recommended(APIView):
    @swagger_auto_schema(operation_description="Recommended fetching using a users preference",
    responses={200: "Recommended Details using a users preference fetched succesfully",400:"Passes an error message"})
    def get(self,request):
        if request.headers.get('token'):
            if UserProfile.objects.filter(auth_token=request.headers.get('token')).exists():
                user = UserProfile.objects.get(auth_token=request.headers.get('token'))
                if Preference.objects.filter(user__id = user.id):
                    preference = Preference.objects.get(user__id = user.id)
                    query = Q()
                    if preference.industries:
                        query |= Q(industry__in=preference.industries)
                    if not request.GET.get('type'):
                        if preference.profile:
                            query |= Q(entity_type__in=preference.profile)
                    if request.GET.get('type') != "advisor":
                        if preference.price_starting is not None:
                            query |= Q(range_starting__gte=preference.price_starting)
                        if preference.price_starting is not None:
                            query |= Q(range_ending__lte=preference.price_ending)
                    if request.GET.get('type'):
                        query &= Q(entity_type=request.GET.get('type')) if request.GET.get('type') != "advisor" else Q(type="advisor")
                    serializer = SaleProfilesSerial(SaleProfiles.objects.filter(query).order_by('-id'), many=True) if request.GET.get('type') != "advisor" else ProfileSerial(Profile.objects.filter(query).order_by('-id'), many=True)
                    return Response(serializer.data)
                return Response({'status':False,'message': 'Preference doesnot exist'})
            return Response({'status':False,'message': 'User doesnot exist'})
        return Response({'status':False,'message': 'Token is not passed'})

# Banner Passing
class Banners(APIView):
    @swagger_auto_schema(operation_description="Banner fetching",
    responses={200: "Banner Details fetched succesfully",400:"Passes an error message"})
    def get(self,request):
        if request.headers.get('token'):
            if UserProfile.objects.filter(auth_token=request.headers.get('token')).exists() and not UserProfile.objects.get(auth_token=request.headers.get('token')).block:
                if not request.GET.get('type'):
                    serializer=BannerSerial(Banner.objects.all().order_by('-id'), many=True)  
                else:
                    serializer = BannerSerial(Banner.objects.filter(type=request.GET.get('type'), validity_date__gte=timezone.now()).order_by('-id')[:5], many=True)
                return Response(serializer.data)
            return Response({'status':False,'message': 'User doesnot exist'})
        return Response({'status':False,'message': 'Token is not passed'})

# Plans
class Plans(APIView):
    @swagger_auto_schema(operation_description="Plans fetching", 
    responses={200: "Plans Details fetched succesfully",400:"Passes an error message"})
    def get(self,request):
        if request.headers.get('token'):
            if UserProfile.objects.filter(auth_token=request.headers.get('token')).exists() and not UserProfile.objects.get(auth_token=request.headers.get('token')).block:
                serializer = PlanSerial(Plan.objects.all().order_by('-id'), many=True)
                return Response(serializer.data)
            return Response({'status':False,'message': 'User doesnot exist'})
        return Response({'status':False,'message': 'Token is not passed'})

# Check subscriptions
class Subscribe(APIView):
    @swagger_auto_schema(operation_description="Subscription fetching",
    responses={200: "Subscription Details fetched succesfully",400:"Passes an error message"})
    def get(self,request):
        if request.headers.get('token'):
            if UserProfile.objects.filter(auth_token=request.headers.get('token')).exists():
                user = UserProfile.objects.get(auth_token=request.headers.get('token'))
                if Subscription.objects.filter(user=user).exists():
                    subscribed = Subscription.objects.get(user=user)
                    if subscribed.remaining_posts != 0 and subscribed.expiry_date >= timezone.now().date():
                        return Response({'status':True,'id':subscribed.plan.id,'posts':subscribed.remaining_posts, "expiry":subscribed.expiry_date})
                return Response({'status':False,'message': 'Subscription doesnot exist'})
            return Response({'status':False,'message': 'User doesnot exist'})
        return Response({'status':False,'message': 'Token is not passed'})

    @swagger_auto_schema(operation_description="Subscrided plan details creation",request_body=SubscribeSerial,
    responses={200: "{'status':True,'message': 'Subscrided plan details created successfully'}",400:"Passes an error message"})
    def post(self,request):
        if request.headers.get('token'):
            if UserProfile.objects.filter(auth_token=request.headers.get('token')).exists():
                user = UserProfile.objects.get(auth_token=request.headers.get('token'))
                # verified, payment_details = verify_payment(request.data.get('transaction_id'))
                # verified, payment_details = await verify_payment(request.data.get('transaction_id'))
                # if verified:
                if not Subscription.objects.filter(user=user).exists():
                    request.data['user'] = user.id
                    plan = Plan.objects.get(id=request.data.get('id'))
                    request.data['expiry_date'] = (timezone.now() + relativedelta(months=plan.time_period)).date()
                    request.data['remaining_posts'] = plan.post_number
                    request.data['plan'] = plan.id
                    serializer = SubscribeSerial(data = request.data)
                    if serializer.is_valid():
                        serializer.save()
                        return Response({'status':True})
                    return Response(serializer.errors)
                plan = Plan.objects.get(id=request.data.get('id'))
                subscribed = Subscription.objects.get(user=user)
                subscribed.plan = plan
                subscribed.expiry_date = (timezone.now() + relativedelta(months=plan.time_period)).date()
                subscribed.remaining_posts = plan.post_number
                subscribed.save()
                return Response({'status':True})
                # else:
                #     return Response({'status':False,'message': f'Transaction not found {payment_details}' })
            return Response({'status':False,'message': 'User doesnot exist'})
        return Response({'status':False,'message': 'Token is not passed'})

# Featured Posts
class Featured(APIView):
    @swagger_auto_schema(operation_description="Featured fetching",
    responses={200: "Featured Details fetched succesfully",400:"Passes an error message"})
    def get(self,request):
        if request.headers.get('token'):
            if UserProfile.objects.filter(auth_token=request.headers.get('token')).exists():
                user = UserProfile.objects.get(auth_token=request.headers.get('token'))
                data = []
                product = SaleProfiles.objects.filter(entity_type=request.GET.get('type')).order_by('-id') if request.GET.get('type') and request.GET.get('type') != "advisor" else Profile.objects.filter(type = "advisor").order_by('-id') if request.GET.get('type') == "advisor" else SaleProfiles.objects.all().order_by('-id')
                for i in product:
                    if Subscription.objects.filter(user=i.user).exists():
                        subscribed = Subscription.objects.get(user=i.user)
                        if Plan.objects.get(id = subscribed.plan.id).feature:
                            data.append(i)
                serial = SaleProfilesSerial if request.GET.get('type') and request.GET.get('type') != "advisor" else ProfileSerial if request.GET.get('type') == "advisor" else SaleProfilesSerial
                serializer = serial(data, many=True)
                return Response(serializer.data)
            return Response({'status':False,'message': 'User doesnot exist'})
        return Response({'status':False,'message': 'Token is not passed'})

# Latest Posts
class Latest(APIView):
    @swagger_auto_schema(operation_description="Latest Posts fetching",
    responses={200: "Latest Posts Details fetched succesfully",400:"Passes an error message"})
    def get(self,request):
        if request.headers.get('token'):
            if UserProfile.objects.filter(auth_token=request.headers.get('token')).exists():
                product = SaleProfiles.objects.filter(entity_type=request.GET.get('type')).order_by('-id')[:10] if request.GET.get('type') and request.GET.get('type') != "advisor" else Profile.objects.filter(type = "advisor").order_by('-id') if request.GET.get('type') == "advisor" else  SaleProfiles.objects.all().order_by('-id')[:10]
                serializer = SaleProfilesSerial(product, many=True) if request.GET.get('type') and request.GET.get('type') != "advisor" else ProfileSerial(product, many=True) if request.GET.get('type') == "advisor" else SaleProfilesSerial(product, many=True)
                return Response(serializer.data)
            return Response({'status':False,'message': 'User doesnot exist'})
        return Response({'status':False,'message': 'Token is not passed'})

# Notification
class Notifications(APIView):
    @swagger_auto_schema(operation_description="Notifications fetching",
    responses={200: "Notifications Details fetched succesfully",400:"Passes an error message"})
    def get(self,request):
        if request.headers.get('token'):
            if UserProfile.objects.filter(auth_token=request.headers.get('token')).exists():
                user = UserProfile.objects.get(auth_token=request.headers.get('token'))
                serializer = NotiSerial(user.notifications.all().order_by('-id'),many=True)
                return Response(serializer.data)
            return Response({'status':False,'message': 'User doesnot exist'})
        return Response({'status':False,'message': 'Token is not passed'})

    @swagger_auto_schema(operation_description="Notification deletion",request_body=NotiSerial,
    responses={200: "{'status':True,'message': 'Notification deleted successfully'}",400:"Passes an error message"})
    def delete(self,request,id):
        if request.headers.get('token'):
            if UserProfile.objects.filter(auth_token=request.headers.get('token')).exists():
                user = UserProfile.objects.get(auth_token=request.headers.get('token'))
                noti = Notification.objects.get(id=id)
                noti.user.remove(user)
                return Response({'status':True})
            return Response({'status':False,'message': 'User doesnot exist'})
        return Response({'status':False,'message': 'Token is not passed'})

# Graph details passing
class Graph(APIView):
    @swagger_auto_schema(operation_description="Graph data fetching",
    responses={200: "Graph Details fetched succesfully",400:"Passes an error message"})
    def get(self,request):
        if request.headers.get('token'):
            if UserProfile.objects.filter(auth_token=request.headers.get('token')).exists() and not UserProfile.objects.get(auth_token=request.headers.get('token')).block:
                businessData = SaleProfiles.objects.filter(entity_type='business').annotate(month=ExtractMonth("listed_on")).values("month").annotate(total_rate=Sum("range_starting")).values("month", "total_rate")[:5]
                investorData = SaleProfiles.objects.filter(entity_type='investor').annotate(month=ExtractMonth("listed_on")).values("month").annotate(total_rate=Sum("range_starting")).values("month", "total_rate")[:5]
                franchiseData = SaleProfiles.objects.filter(entity_type='franchise').annotate(month=ExtractMonth("listed_on")).values("month").annotate(total_rate=Sum("range_starting")).values("month", "total_rate")[:5]
                investAmount=0
                totalAmount = 0
                for i in investorData:
                    if i['total_rate'] != None:
                        investAmount += int(i['total_rate'])
                for i in businessData:
                    if i['total_rate'] != None:
                        totalAmount += int(i['total_rate'])
                for i in investorData:
                    if i['total_rate'] != None:
                        totalAmount += int(i['total_rate'])
                totalAmount += investAmount
                return Response({"business":businessData,"investor":investorData,"franchise":franchiseData,"total":totalAmount,"invest":investAmount})
            return Response({'status':False,'message': 'User doesnot exist'})
        return Response({'status':False,'message': 'Token is not passed'})

# Contact Us
class Contact(APIView):
    @swagger_auto_schema(operation_description="Business creation",request_body=ContactSerial,
    responses={200: "{'status':True,'message': 'Contact created successfully'}",400:"Passes an error message"})
    def post(self,request):
        if request.headers.get('token'):
            if UserProfile.objects.filter(auth_token=request.headers.get('token')).exists() and not UserProfile.objects.get(auth_token=request.headers.get('token')).block:
                serializer = ContactSerial(data = request.data)
                if serializer.is_valid():
                    serializer.save()
                    return Response({'status':True})
                return Response(serializer.errors)
            return Response({'status':False,'message': 'User doesnot exist'})
        return Response({'status':False,'message': 'Token is not passed'})

# Check userid of logged user
class User(APIView):
    def get(self, request):
        if request.headers.get('token'):
            if UserProfile.objects.filter(auth_token=request.headers.get('token')).exists() and not UserProfile.objects.get(auth_token=request.headers.get('token')).block:
                user = UserProfile.objects.get(auth_token=request.headers.get('token'))
                return Response({'status': True, 'userId': user.id})
            return Response({'status':False,'message': 'User doesnot exist'})
        return Response({'status':False,'message': 'Token is not passed'})

# Update onesignal id of a user after login
@api_view(['POST'])
def onesignal_id(request):
    if request.headers.get('token'):
        if UserProfile.objects.filter(auth_token=request.headers.get('token')).exists() and not UserProfile.objects.get(auth_token=request.headers.get('token')).block:
            user = UserProfile.objects.get(auth_token=request.headers.get('token'))
            if user.onesignal_id != request.data.get('onesignal_id'):
                user.onesignal_id = request.data.get('onesignal_id')
                user.save()
                return Response({'status': True})
            return Response({'status':False,'message': 'Onesignal id already exist'})
        return Response({'status':False,'message': 'User doesnot exist'})
    return Response({'status':False,'message': 'Token is not passed'})

# popular searched items
class Popularsearch(APIView):
    @swagger_auto_schema(operation_description="Fetching popular searched items",
                         responses={200: "Featured Details fetched successfully", 400: "Passes an error message"})
    def get(self, request):
        token = request.headers.get('token')
        if not token:
            return Response({'status': False, 'message': 'Token is not passed'}, status=status.HTTP_400_BAD_REQUEST)

        user = UserProfile.objects.filter(auth_token=token, block=False).first()
        if not user:
            return Response({'status': False, 'message': 'User does not exist'}, status=status.HTTP_404_NOT_FOUND)

        popular_searches = Activity.objects.order_by('-count')[:10]
        serializer = ActivitySerial(popular_searches, many=True)
        return Response({'status': True, 'data': serializer.data}, status=status.HTTP_200_OK)

    @swagger_auto_schema(operation_description="Record or increment count of a searched item",
                         request_body=ActivitySerial,
                         responses={201: "Interaction recorded successfully", 400: "Error message"})
    def post(self, request):
        token = request.headers.get('token')
        if not token:
            return Response({'status': False, 'message': 'Token is not passed'}, status=status.HTTP_400_BAD_REQUEST)

        user = UserProfile.objects.filter(auth_token=token, block=False).first()
        if not user:
            return Response({'status': False, 'message': 'User does not exist'}, status=status.HTTP_404_NOT_FOUND)

        post_id = request.data.get('post_id')
        if not post_id:
            return Response({'status': False, 'message': 'Post ID is required'}, status=status.HTTP_400_BAD_REQUEST)

        try:
            post = SaleProfiles.objects.get(id=post_id)
            activity, created = Activity.objects.get_or_create( post=post,user__isnull=True, defaults={'count': 1})
            if not created:
                activity.count += 1
                activity.save()
            return Response({'status': True, 'message': 'Interaction recorded successfully'}, status=status.HTTP_201_CREATED)
        except SaleProfiles.DoesNotExist:
            return Response({'status': False, 'message': 'Post does not exist'}, status=status.HTTP_404_NOT_FOUND)

    @swagger_auto_schema(operation_description="Update the count or details of a specific activity",
                         request_body=ActivitySerial,
                         responses={200: "Activity updated successfully", 400: "Error message"})
    def patch(self, request, id):
        token = request.headers.get('token')
        if not token:
            return Response({'status': False, 'message': 'Token is not passed'}, status=status.HTTP_400_BAD_REQUEST)

        user = UserProfile.objects.filter(auth_token=token, block=False).first()
        if not user:
            return Response({'status': False, 'message': 'User does not exist'}, status=status.HTTP_404_NOT_FOUND)

        try:
            activity = Activity.objects.get(id=id, user=user)
            serializer = ActivitySerial(activity, data=request.data, partial=True)
            if serializer.is_valid():
                serializer.save()
                return Response({'status': True, 'message': 'Successfully updated'}, status=status.HTTP_200_OK)
            return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)
        except Activity.DoesNotExist:
            return Response({'status': False, 'message': 'Activity not found'}, status=status.HTTP_404_NOT_FOUND)

    @swagger_auto_schema(operation_description="Delete a specific activity",
                         responses={200: "Activity deleted successfully", 400: "Error message"})
    def delete(self, request, id):
        token = request.headers.get('token')
        if not token:
            return Response({'status': False, 'message': 'Token is not passed'}, status=status.HTTP_400_BAD_REQUEST)

        user = UserProfile.objects.filter(auth_token=token, block=False).first()
        if not user:
            return Response({'status': False, 'message': 'User does not exist'}, status=status.HTTP_404_NOT_FOUND)

        try:
            activity = Activity.objects.get(id=id, user=user)
            activity.delete()
            return Response({'status': True, 'message': 'Activity deleted successfully'}, status=status.HTTP_200_OK)
        except Activity.DoesNotExist:
            return Response({'status': False, 'message': 'Activity not found'}, status=status.HTTP_404_NOT_FOUND)

# recently Searched posts
class RecentSearchview(APIView):
    @swagger_auto_schema(operation_description="Fetching Recently Serached items",
                         responses={200: "Fetched successfully", 400: "Passes an error message"})
    def get(self, request):   
        token = request.headers.get('token')
        if not token:
            return Response({'status': False, 'message': 'Token is not passed'}, status=status.HTTP_400_BAD_REQUEST)

        user = UserProfile.objects.filter(auth_token=token, block=False).first()
        if not user:
            return Response({'status': False, 'message': 'User does not exist'}, status=status.HTTP_404_NOT_FOUND)

        recent_views = Activity.objects.filter(user=user).order_by('-created')[:10]
        serializer = ActivitySerial(recent_views, many=True)
        return Response({'status': True, 'data': serializer.data}, status=status.HTTP_200_OK)

    @swagger_auto_schema(operation_description="Record or increment count of a viewed item",
                         request_body=ActivitySerial, 
                         responses={201: "Interaction recorded successfully", 400: "Error message"})
    def post(self, request):
        token = request.headers.get('token')
        if not token:
            return Response({'status': False, 'message': 'Token is not passed'}, status=status.HTTP_400_BAD_REQUEST)

        user = UserProfile.objects.filter(auth_token=token, block=False).first()
        if not user:
            return Response({'status': False, 'message': 'User does not exist'}, status=status.HTTP_404_NOT_FOUND)

        post_id = request.data.get('post_id')
        if not post_id:
            return Response({'status': False,'message': 'Post ID is required'}, status=status.HTTP_400_BAD_REQUEST)

        try:
            post = SaleProfiles.objects.get(id=post_id)
            activity= Activity.objects.create(user=user, post=post)
            activity.save()
            return Response({'status': True, 'message': 'Interaction recorded successfully'}, status=status.HTTP_201_CREATED)
        
        except SaleProfiles.DoesNotExist:
            return Response({'status': False, 'message': 'Post does not exist'}, status=status.HTTP_404_NOT_FOUND)

    @swagger_auto_schema(operation_description="Update the details of a specific activity",
                         request_body=ActivitySerial,
                         responses={200: "Activity updated successfully", 400: "Error message"})
    def patch(self, request, id):
        token = request.headers.get('token')
        if not token:
            return Response({'status': False, 'message': 'Token is not passed'}, status=status.HTTP_400_BAD_REQUEST)

        user = UserProfile.objects.filter(auth_token=token, block=False).first()
        if not user:
            return Response({'status': False, 'message': 'User does not exist'}, status=status.HTTP_404_NOT_FOUND)

        try:
            activity = Activity.objects.get(id=id, user=user)
            serializer = ActivitySerial(activity, data=request.data, partial=True)
            if serializer.is_valid():
                serializer.save()
                return Response({'status': True, 'message': 'Successfully updated'}, status=status.HTTP_200_OK)
            return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)
        except Activity.DoesNotExist:
            return Response({'status': False, 'message': 'Activity not found'}, status=status.HTTP_404_NOT_FOUND)

    @swagger_auto_schema(operation_description="Delete a specific activity",
                         responses={200: "Activity deleted successfully", 400: "Error message"})
    def delete(self, request, id):
        token = request.headers.get('token')
        if not token:
            return Response({'status': False, 'message': 'Token is not passed'}, status=status.HTTP_400_BAD_REQUEST)

        user = UserProfile.objects.filter(auth_token=token, block=False).first()
        if not user:
            return Response({'status': False, 'message':'User does not exist'}, status=status.HTTP_404_NOT_FOUND)

        try:
            activity = Activity.objects.get(id=id,user=user)
            activity.delete()
            return Response({'status': True, 'message': 'Activity deleted successfully'}, status=status.HTTP_200_OK)
        except Activity.DoesNotExist:
            return Response({'status': False, 'message': 'Activity not found'}, status=status.HTTP_404_NOT_FOUND)


# Report Post
class ReportPost(APIView):
    @swagger_auto_schema(operation_description="Report a post or profile",
    request_body=openapi.Schema(type=openapi.TYPE_OBJECT, required=['id', 'reason', 'reason_type'],
    properties={'id': openapi.Schema(type=openapi.TYPE_INTEGER, description='ID of the post or profile to report'),
                'reason': openapi.Schema(type=openapi.TYPE_STRING, description='Reason for reporting'),
                'reason_type': openapi.Schema(type=openapi.TYPE_STRING, description='Type of reason (e.g., "spam", "harassment")'),}),
    responses={200: "{'status':True,'message': 'Reported successfully'}", 400: "{'status':False,'message': 'Invalid ID, reason, or reason type'}"})
    def post(self, request, *args, **kwargs):
        report_id = request.data.get('id')
        reason = request.data.get('reason')
        reason_type = request.data.get('reason_type')
        if not report_id or not reason or not reason_type:
            return Response({'status': False, 'message': 'Invalid ID, reason, or reason type'}, status=status.HTTP_400_BAD_REQUEST)

        
        token = request.headers.get('token')
        if token:
            try:
                user = UserProfile.objects.get(auth_token=token)
                if user.block:
                    return Response({'status': False, 'message': 'User is blocked'}, status=status.HTTP_403_FORBIDDEN)
            except UserProfile.DoesNotExist:
                return Response({'status': False, 'message': 'User does not exist'}, status=status.HTTP_404_NOT_FOUND)
        else:
            return Response({'status': False, 'message': 'Token is not passed'}, status=status.HTTP_400_BAD_REQUEST)

    
        if SaleProfiles.objects.filter(id=report_id).exists():
          
            report = Report(report_post=SaleProfiles.objects.get(id=report_id), reason=reason, reason_type=reason_type, reported_by=user, report_type='post')
            report.save()
            return Response({'status': True, 'message': 'Post reported successfully'}, status=status.HTTP_200_OK)

       
        if Profile.objects.filter(id=report_id).exists():
          
            report = Report(reported_profile=Profile.objects.get(id=report_id), reason=reason, reason_type=reason_type, reported_by=user, report_type='profile')
            report.save()
            return Response({'status': True, 'message':'Profile reported successfully'}, status=status.HTTP_200_OK)

        return Response({'status': False, 'message': 'Post or Profile does not exist'}, status=status.HTTP_404_NOT_FOUND)

class RecentEnquiries(APIView):
    @swagger_auto_schema(operation_description="Fetch recent enquiries",
    responses={200: "{'status':True,'message': 'Fetched successfully'}"})
    def get(self, request):
        token = request.headers.get('token')
        if token:
            try:
                user = UserProfile.objects.get(auth_token=token)
                if user.block:
                    return Response({'status': False, 'message': 'User is blocked'})
                user_posts = SaleProfiles.objects.filter(user=user)
                if not user_posts.exists():
                    return Response({'status': False, 'message': 'User has not added any posts'})
                user_post_type = user_posts.first().entity_type
                requested_post_type = request.GET.get('post_type')
                if requested_post_type and requested_post_type != user_post_type:
                    return Response({'status': False, 'message': 'Requested post type does not match user\'s post type'})
                recent_rooms = Room.objects.filter(
                    Q(first_person=user) | Q(second_person=user)
                ).order_by('-created_date')  
                enquiries_data = []
                for room in recent_rooms:
                    if ChatMessage.objects.filter(room=room).exists():
                        other_person = room.second_person if room.first_person == user else room.first_person
                        print(other_person.image)   
                        enquiry_info = {
                            'other_person': other_person.username,  
                            'created_date': room.created_date,
                            'post_type': user_post_type  # Get the type of the user's first post
                        }
                        enquiries_data.append(enquiry_info)

                return Response({'status': True, 'recent_enquiries': enquiries_data})
            except UserProfile.DoesNotExist:
                return Response({'status': False, 'message': 'User does not exist'})
        return Response({'status': False, 'message': 'Token is not passed'})


class EnquiriesCounts(APIView):
    @swagger_auto_schema(
        operation_description="Fetch enquiries counts",
        responses={200: "{'status':True,'message': 'Fetched successfully'}"}
    )
    def get(self, request):
        token = request.headers.get('token')
        if token:
            try:
                user = UserProfile.objects.get(auth_token=token)
                if user.block:
                    return Response({'status': False, 'message': 'User is blocked'})

                # Check if the user has added any posts
                user_posts = SaleProfiles.objects.filter(user=user)
                if not user_posts.exists():
                    return Response({'status': False, 'message': 'User has not added any posts'})

                today = timezone.now().date()
                yesterday = today - timedelta(days=1)

                has_messages = ChatMessage.objects.filter(room=OuterRef('pk'))

                today_count = Room.objects.filter(
                    Q(first_person=user) | Q(second_person=user),
                    created_date__date=today
                ).filter(Exists(has_messages)).count()

                yesterday_count = Room.objects.filter(
                    Q(first_person=user) | Q(second_person=user),
                    created_date__date=yesterday
                ).filter(Exists(has_messages)).count()

                total_count = Room.objects.filter(
                    Q(first_person=user) | Q(second_person=user)
                ).filter(Exists(has_messages)).count()

                return Response({
                    'status': True,
                    'today_count': today_count,
                    'yesterday_count': yesterday_count,
                    'total_count': total_count  
                })
            except UserProfile.DoesNotExist:
                return Response({'status': False, 'message': 'User does not exist'})
        return Response({'status': False, 'message': 'Token is not passed'})
