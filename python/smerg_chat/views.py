from django.shortcuts import render
from .models import *
from .serializers import *
from rest_framework.views import APIView
# from adrf.views import APIView
from rest_framework.response import Response
from django.db.models import Q
from .utils.enc_utils import *
from smerg_app.utils.async_serial_utils import *

# Rooms
class Rooms(APIView):
    def get(self, request):
        if request.headers.get('token'):
            if UserProfile.objects.filter(auth_token=request.headers.get('token')).exists() and not UserProfile.objects.get(auth_token=request.headers.get('token')).block:
                serializer = RoomSerial(Room.objects.filter(Q(first_person=UserProfile.objects.get(auth_token=request.headers.get('token'))) | Q(second_person=UserProfile.objects.get(auth_token=request.headers.get('token')))),many= True)
                return Response(serializer.data)
            return Response({'status':False,'message': 'User doesnot exist'})
        return Response({'status':False,'message': 'Token is not passed'})

    def post(self, request):
        if request.headers.get('token'):
            if UserProfile.objects.filter(auth_token=request.headers.get('token')).exists() and not UserProfile.objects.get(auth_token=request.headers.get('token')).block:
                user = UserProfile.objects.get(auth_token=request.headers.get('token'))
                name = SaleProfiles.objects.get(id=request.data.get('receiverId')).user.first_name
                image = SaleProfiles.objects.get(id=request.data.get('receiverId')).user.image.url if SaleProfiles.objects.get(id=request.data.get('receiverId')).user.image and hasattr(SaleProfiles.objects.get(id=request.data.get('receiverId')).user.image, 'url') else None
                if Room.objects.filter(first_person=user,second_person=SaleProfiles.objects.get(id=request.data.get('receiverId')).user).exists() or Room.objects.filter(second_person=user,first_person=SaleProfiles.objects.get(id=request.data.get('receiverId')).user).exists():
                    return Response({'status':True, 'name':name, 'image':image, 'roomId':Room.objects.get(first_person=user,second_person=SaleProfiles.objects.get(id=request.data.get('receiverId')).user).id})
                # room = Room.objects.create(first_person=user,second_person=SaleProfiles.objects.get(id=request.data.get('receiverId')).user,last_msg="Tap to send message")
                room = Room.objects.create(first_person=user,second_person=SaleProfiles.objects.get(id=request.data.get('receiverId')).user,last_msg=encrypt_message("Tap to send message"))
                return Response({'status':True,'name':name, 'image':image, 'roomId':room.id})
            return Response({'status':False,'message': 'User doesnot exist'})
        return Response({'status':False,'message': 'Token is not passed'})

# Chat of 2 users
class Chat(APIView):
    def get(self, request):
        if request.headers.get('token'):
            if UserProfile.objects.filter(auth_token=request.headers.get('token')).exists() and not UserProfile.objects.get(auth_token=request.headers.get('token')).block:
                user = UserProfile.objects.get(auth_token=request.headers.get('token'))
                serializer = ChatSerial(ChatMessage.objects.filter(room__id = request.GET.get('roomId')).order_by('-id'),many= True)
                room = Room.objects.get(id = request.GET.get('roomId'))
                number = room.second_person.username if user.id == room.first_person.id else room.first_person.username
                return Response({'messages': serializer.data, 'number': number })
            return Response({'status':False,'message': 'User doesnot exist'})
        return Response({'status':False,'message': 'Token is not passed'})