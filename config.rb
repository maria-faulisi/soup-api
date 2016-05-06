###
# Page options, layouts, aliases and proxies
###

# Per-page layout changes:
#
# With no layout
page '/*.xml', layout: false
page '/*.json', layout: false
page '/*.txt', layout: false

activate :directory_indexes

# With alternative layout
# page "/path/to/file.html", layout: :otherlayout

# Proxy pages (http://middlemanapp.com/basics/dynamic-pages/)
# proxy "/this-page-has-no-template.html", "/template-file.html", locals: {
#  which_fake_page: "Rendering a fake page with a local variable" }

ingredients = {}
counter = 1

data.soups.each do |soup|
  if soup.attributes[0]['ingredients']
    soup_ingredients = soup.attributes[0]['ingredients'].split(', ')
  end

  soup_ingredient_list = []

  soup_ingredients.each do |ingredient|
    # if ingredient is not in ingredients{}, add it
    if !ingredients.has_value?(ingredient.downcase)      
      # with an id that is incremented
      # ingredients.store({id: counter, name: ingredient})
      new_ingredient = {id: counter, title: ingredient}
      ingredients[ingredient.downcase] = (new_ingredient)
      counter += 1
    end

    # also add to current soup_ingredient_list
    soup_ingredient_list << (ingredients[ingredient.downcase])
  end
  
  proxy "/api/soups/#{soup.attributes[0]['slug']}/ingredients", "api/soups/ingredients.json",locals: {ingredients: soup_ingredient_list}, ignore: true
  proxy "/api/soups/#{soup.attributes[0]['slug']}","api/soups/soup.json", locals:{soup: soup}, ignore: true
end
  
proxy "/api/soups", "api/soups.json", ignore: true

# General configuration

###
# Helpers
###

# Methods defined in the helpers block are available in templates
# helpers do
#   def some_helper
#     "Helping"
#   end
# end

# Build-specific configuration
configure :build do
  # Minify CSS on build
  # activate :minify_css

  # Minify Javascript on build
  # activate :minify_javascript
end
