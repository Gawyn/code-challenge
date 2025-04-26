# Extract Van Gogh Paintings Code Challenge

Goal is to extract a list of Van Gogh paintings from the attached Google search results page.

![Van Gogh paintings](https://github.com/serpapi/code-challenge/blob/master/files/van-gogh-paintings.png?raw=true "Van Gogh paintings")

## Instructions

This is already fully supported on SerpApi. ([relevant test], [html file], [sample json], and [expected array].)
Try to come up with your own solution and your own test.
Extract the painting `name`, `extensions` array (date), and Google `link` in an array.

Fork this repository and make a PR when ready.

Programming language wise, Ruby (with RSpec tests) is strongly suggested but feel free to use whatever you feel like.

Parse directly the HTML result page ([html file]) in this repository. No extra HTTP requests should be needed for anything.

[relevant test]: https://github.com/serpapi/test-knowledge-graph-desktop/blob/master/spec/knowledge_graph_claude_monet_paintings_spec.rb
[sample json]: https://raw.githubusercontent.com/serpapi/code-challenge/master/files/van-gogh-paintings.json
[html file]: https://raw.githubusercontent.com/serpapi/code-challenge/master/files/van-gogh-paintings.html
[expected array]: https://raw.githubusercontent.com/serpapi/code-challenge/master/files/expected-array.json

Add also to your array the painting thumbnails present in the result page file (not the ones where extra requests are needed). 

Test against 2 other similar result pages to make sure it works against different layouts. (Pages that contain the same kind of carrousel. Don't necessarily have to be paintings.)

The suggested time for this challenge is 4 hours. But, you can take your time and work more on it if you want.

## Commentary

The exercise for me had two parts. I started with the assumption that using a "pure" HTML parser, like Nokogiri would be enough. For the task, I chose Nokolexbor: David Sojevic talked about it during the first interview, and I decided to use it instead of Nokogiri. I built using TDD, so I first wrote a test based on the files already in the repo, and started working from there. I reviewed the structure of the HTML file, which is the same one you get using Google Search as of today (hopefully that doesn't change very often) and found the classes in which the relevant information is stored. That worked for three of the four attributes: name, extensions and link. It didn't worked for image. Taking another look at the page, it became clear that there was some Javascript that modified the HTML, replacing the images once the page loads.

Here started the second part of the exercise for me. How to deal with the modifications on the executed with JS? I thought of two ways. The first, the more direct one and the one I finally chose, was to open the page with a "real" browser, and then fetch the modified HTML from it. This is what is commonly done with integration tests. The second one would be to check what the JS was doing and try to go around it without executing the JS itself. This second option would be more performant (browsers are comparatively slow), but way more complicated and easier to break. Therefore, I decided to go with the first option.

To implement it, I first used Watir (something like Capybara), but later I realized that, given that I didn't need to manipulate the HTML at all, I could just use Selenium to load the HTML. At this point, I did consider remove the Nokolexbor dependency and just fetch all the elements using Selenium, but the difference would be small, and the possibility that Nokolexbor was more performant intrigued me. Moreover, it's your exercise, so it's nice to use your library. :)
