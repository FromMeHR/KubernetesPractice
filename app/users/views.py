from django.views.generic.list import ListView

from .models import CustomUser


class AllUsers(ListView):
    model = CustomUser
    template_name = "users/all_users.html"
    context_object_name = "all_users"

    def get_context_data(self, **kwargs):
        context = super().get_context_data(**kwargs)
        context["title"] = "All Users"
        return context