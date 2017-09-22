options =
  api_key: ""

refreshFrequency: 900

command: "curl --silent https://www.wanikani.com/api/user/#{options.api_key}/study-queue"

render: (output) -> """

<div class="row">

<div>

    <img src="/wanikani/crabigator.png">

</div>

<div>

  <p><b>Reviews</b> <label id="reviews-available">-</label></p>
  <p><b>Lessons</b> <label id="lessons-available">-</label></p>

</div>

</div>

"""

style: """

position: absolute;
right: 0;
bottom 0;
margin: 1rem;

color: #FFFFFF;
font-family: 'Roboto', sans-serif;

img
  user-drag: none; 
  user-select: none;

.row 
  display: flex;
  flex-direction: row;

  img
    height: 36px;
    width: 36px;

  :first-child
    margin-right: .3rem;

p
  margin: 0;

"""

update: (output, domEl) ->
  try
    data = JSON.parse(output)
  catch e
    return 0

  ui = data.user_information
  ri = data.requested_information

  $(domEl).find('#reviews-available').text(ri.reviews_available)
  $(domEl).find('#lessons-available').text(ri.lessons_available)

afterRender: (widget) ->
  $.ajax({
    url: "https://ajax.googleapis.com/ajax/libs/jqueryui/1.11.4/jquery-ui.min.js",
    cache: true,
    dataType: "script",
    success: ->
      $(widget).draggable()
      return
  })