endpoints =
  '/wordpress/wp-json/' : 'api/root.json'
  '/wordpress/wp-json/posts/1' : 'api/post1.json'
  '/wordpress/wp-json/posts?category_name=books' : 'api/bookPosts.json'
  '/wordpress/wp-json/posts?category_name=blog' : 'api/blogPosts.json'
  '/wordpress/wp-json/pages/' : 'api/pages.json'
  '/wordpress/wp-json/pages/home' : 'api/home.json'
  '/wordpress/wp-json/pages/about' : 'api/about.json'
  '/wordpress/wp-json/pages/contact' : 'api/contact.json'
module.exports = endpoints