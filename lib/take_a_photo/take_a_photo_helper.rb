module ActionView
  module Helpers
    module TakeAPhotoHelper
      # Add a Take A Photo flash object into the view
      #
      # options :
      #  * id - The ID of the object
      #  * message - An optional message to show if Adobe Flash is not installed
      #  * on_start - The name of a javascript funcion to call after the photo begin taken
      #  * on_progress - The name of a javascript funcion to call while the photo is processing
      #  * on_complete - The name of a javascript funcion to call before the photo begin taken
      #  * upload_url - The URL where to do the POST of the data
      def take_a_photo_camera(options = {})
        url = "/TakeAPhoto.swf"
        id = options[:id] || "take_a_photo"

        %(<div id="#{id}">
          <p>#{options[:message] || "You need yo install Adobe Flash Player"}</p>
        </div><script type="text/javascript">
          var flashvars = {
            onStart: "#{options[:on_start] || 'void(0)'}",
            onProgress: "#{options[:on_progress] || 'void(0)'}",
            onComplete: "#{options[:on_complete] || 'void(0)'}",
            upload_url: "#{options[:upload_url]}",
          };
          swfobject.embedSWF("#{url}", "#{id}", "450", "337", "9.0.0", "", flashvars, {}, {});
          </script>)
      end
      
      def take_a_photo_shoot_button(options = {})
        id = options[:id] || "take_a_photo"
        label = options[:label] || "Take A Photo"
        css = options[:class].blank? ? "" : "class='#{options[:class]}'"
        
        %(<a href="javascript: $('#{id}').take();" #{css}>#{label}</a>)
      end
    end
  end
end