from django.db import models
import taggit.managers

class Blog(models.Model):
    name = models.CharField(max_length = 128)

    def __unicode__(self):
        return self.name

class Author(models.Model):
    name = models.CharField(max_length = 50)
    email = models.EmailField() 

    def __unicode__(self):
        return self.name

class Article(models.Model):
    blog           = models.ForeignKey(Blog)
    author         = models.ForeignKey(Author)
    slug           = models.SlugField(max_length = 128)
    title          = models.CharField(max_length = 128)
    publish_date   = models.DateTimeField('date published')
    published      = models.BooleanField(default = True)
    last_edit_date = models.DateTimeField('date of last edit', auto_now = True)
    content        = models.TextField()
    tags           = taggit.managers.TaggableManager()

    def __unicode__(self):
        return self.title


