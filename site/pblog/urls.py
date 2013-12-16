""" URL Patterns for blog """

from django.conf.urls import patterns, url
import views

urlpatterns = patterns('',
    url(r'^$', views.ArticleIndexView.as_view(), name='index'),
    url(r'^(?P<pk>\d+)/$', views.ArticleDetailView.as_view(), name = 'detail'),
)
