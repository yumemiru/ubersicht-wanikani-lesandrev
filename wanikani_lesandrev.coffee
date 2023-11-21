options =
  endpoint: "https://api.wanikani.com/v2/summary"
  api_key: "" # visit https://www.wanikani.com/settings/personal_access_tokens, put your default read-only token in the quotes 
  api_rev: "20170710"
  spawn_x: "right"
  spawn_y: "bottom"
  spawn_offset_x: 0
  spawn_offset_y: 0

refreshFrequency: 900

command: "curl --silent #{options.endpoint} -H \"#{options.api_rev}\" -H \"Authorization: Bearer #{options.api_key}\""

render: (output) -> """

<div class="row">

<div>

    <img src="/wanikani_lesandrev.widget/crabigator.png">

</div>

<div>

  <p><b>Reviews</b> <label id="reviews-available">-</label></p>
  <p><b>Lessons</b> <label id="lessons-available">-</label></p>

</div>

</div>

"""

style: """

position: absolute;
#{options.spawn_x}: #{options.spawn_offset_x}px;
#{options.spawn_y}: #{options.spawn_offset_y}px;
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
    data = JSON.parse(output).data
  catch e
    return 0

  try
    lessons_count = data.lessons[0].subject_ids.length
  catch e
    lessons_count = 0
    return 0

  try
    reviews_count = data.reviews[0].subject_ids.length
  catch e
    reviews_count = 0
    return 0

  $(domEl).find('#reviews-available').text(reviews_count)
  $(domEl).find('#lessons-available').text(lessons_count)

afterRender: (widget) ->
  $.ajax({
    url: "https://ajax.googleapis.com/ajax/libs/jqueryui/1.11.4/jquery-ui.min.js",
    cache: true,
    dataType: "script",
    success: ->
      $(widget).draggable()
      return
  })
