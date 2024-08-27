from django.urls import path

from users import views


urlpatterns = [
    path('', views.AllUsers.as_view(), name='all_users'),
]