class UrbanHelpline.Admin.Search

  @init: ->

    eventHandler = (event)->
      $.get "/admin/documents/search.json", {search: $(".search-query").val()}, (data)->
        console.log data
        if data.length == 0
          $(".result-area").hide()
          $(".no-results").show()
        else
          $(".result-area").empty()
          for document in data
            html = "<div class='name'>#{document.name}</div>"
            if document["address"] != ""
              html+= "<div class='address'>#{document.address}</div>"
            if document["notes"] != ""
              html+= "<div class='notes'>#{document.notes}</div>"
            element = $("<div class='document'></div>").html(html)
            $(".result-area").append(element)

    $(".search-submit").click eventHandler