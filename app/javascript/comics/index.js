$(document).ready(function() {
  $('.favourite-img').click(function() {
    var that = $(this);
    var comic_id = $(this).data('comic-id');
    $.ajax({
      method: 'POST',
      url: '/comics/favourite_comic.json',
      data: {
        comic: {
          comic_id: comic_id
        }
      },
      success: function(response) {
        if (response.message == 'favourite removed') {
          that.children()[0].src = $('#heart-off-src').attr('src');
        }

        if (response.message == 'favourite added') {
          that.children()[0].src = $('#heart-on-src').attr('src');
        }
      }
    });
  });
});
