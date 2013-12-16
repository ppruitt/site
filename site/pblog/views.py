from django.shortcuts import render, get_object_or_404
from models import Article

def index(request):
    latest_articles = Article.objects.all().order_by('-publish_date')[:5]
    context = { 'latest_articles' : latest_articles }
    return render(request, 'pblog/index.html', context)

def detail(request, article_id):
    article = get_object_or_404(Article, pk = article_id)
    return render(request, 'pblog/detail.html', {'article': article})
