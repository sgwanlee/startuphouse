# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/


$(document).ready ->

	videoUrl_arr = []
	thumbnailUrl_arr = []
	app_key = "VMzhfbZXuyPUIwLmKEWkcRDUA9fSzdsgZsXP4NIp"
	javascript_key = "ooMKBHPMVQ9AnNsj2cEk7LvzYNfqp0KE3tohWuPh"

	Parse.initialize(app_key, javascript_key)

	vounceQuery = new Parse.Query("Vounces")

	id = 'cY4BSJr1Kh'

	vounceQuery.get id,
		success: (vounce)->
			title = vounce.get("title")
			videoRelation = vounce.relation("videos")

			videoRelation.query().find
				success: (video_arr) ->
					video_arr.forEach (video) ->
						videoUrl_arr.push video.get("url")
						thumbnailUrl_arr.push video.get("thumbnails")

					video_count = videoUrl_arr.length

					thumbnail_html = ""
					t = 0
					thumbnailUrl_arr.forEach (url) ->
						thumbnail_html += '<img id="'+t+'" src="'+url+'"/>'
						t++

					$('.thumbnails').append(thumbnail_html)

					videoPlay = (videoNum) ->
						console.log("start play "+videoNum)

						video = $('.startup_vounce video')
						video.attr("src", videoUrl_arr[videoNum])
						video.attr("type", "video/mp4")

						console.log(videoUrl_arr[videoNum])
						
						$('img').removeClass("select")
						$('#'+videoNum).addClass("select")

						video.get(0).load()
						video.get(0).play()

					i = 0
					videoPlay(i)

					#video ended event listner
					$('.startup_vounce video').on('ended', ->
						console.log("end play "+i)
						
						i++
						
						i = 0 if i==video_count
						console.log(i)
						videoPlay(i)
					)

					#thumbnail click event listener
					$('img').on("click", ->
						i = $(this).attr("id")
						videoPlay(i)
					)


