slider = (slider, wrapper) ->
  $slider = $(slider)
  $wrapper = $(wrapper)
  $slides = $('.slide', $slider)
  $selectors = $('.selector a', $slider)
  current = 0
  options =
    width: 1000
    delay: 400

  updateSelector = ->
    $selectors.removeClass('active')
    $selectors.eq(current).addClass('active')

  changeSlide = (i) ->
    $slide = $slides.eq(current)
    if i > current
      return false if $slide.index() >= $slides.length - 1
      $slide.animate {left: -options.width}, options.delay, ->
        $slide.hide()
        $slide.next().show().css({left: options.width})
          .animate({left: 0}, options.delay)
      ++current
      updateSelector()
    else if i < current
      return false if current <= 0
      $slide.animate {left: options.width}, options.delay, ->
        $slide.hide()
        $slide.prev().show().css({left: -options.width})
          .animate({left: 0}, options.delay)
      --current
      updateSelector()
    else
      return false
    changeSlide(i) if i isnt current

  $('.next', $slider).click (e) ->
    changeSlide(current + 1)
    false
  $('.back', $slider).click (e) ->
    changeSlide(current - 1)
    false
  $selectors.click ->
    changeSlide $(this).data('slide')

tabs = (wrapper) ->
  $tabs = $('.tab', $(wrapper))
  $nav = $('.nav li', $(wrapper))
  $nav.click ->
    $this = $(this)
    $nav.removeClass('active')
    $this.addClass('active')
    $tabs.hide()
    $tabs.eq($this.data('tab')).show()

jQuery(document).ready ($) ->
  # console.log "Ready!"
  slider('.slider', '.slide-wrapper')
  tabs('.tabs')
  