root.PhotoPicker.MediaUtils = class MediaUtils
  @scaleImage: (media, longestSideLength = 800) ->
    if media.width > longestSideLength || media.height > longestSideLength
      isPortrait = media.width > media.height
    
      if isPortrait
        width = longestSideLength
        height = media.height * (longestSideLength / media.width)
      else
        width = media.width * (longestSideLength / media.height)
        height = longestSideLength
      
      return media.imageAsResized(width, height)
    else
      return media