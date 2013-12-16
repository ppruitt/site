from django.views import generic
from models import Article

class ArticleIndexView(generic.ListView):
    template_name = 'pblog/index.html'
    context_object_name = 'latest_articles'

    def get_queryset(self):
        """Return the last five published articles."""
        return Article.objects.order_by('-publish_date')[:5]
 
class ArticleDetailView(generic.DetailView):
    model = Article
    template_name = 'pblog/detail.html'
