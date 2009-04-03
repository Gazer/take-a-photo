class TakeAPhoto
  def initialize(params)
    w = params[:width].to_i;
    h = params[:height].to_i;

    image = Magick::Image.new(w, h) { self.background_color = "#ffffff" }
    image.colorspace = Magick::RGBColorspace

    for y in 0..(h-1)
      # convert the string into an array of n elements
      c_y = params["px#{y}"].split(",");
      for x in 0..(w-1)
        # get the single pixel color value
        value = c_y[x];
        # if value is not empty (empty values are the blank pixels)
        if value && value != ""
          # get the hexadecimal string (must be 6 chars length)
          hex = "000000#{value}"[-6,6]

          rgb = hex.scan(/../).map {|color| color.to_i(16) * 65535 / 255}
          image.pixel_color x, y, Magick::Pixel.new(rgb[0], rgb[1], rgb[2])
        end
      end
    end
    file = Tempfile.new('take_a_photo')
    filename = "#{file.path}.jpg"
    file.close

    # if params[:polaroid] == "1"
    #   image['Caption'] = Time.now.strftime('%d/%m/%Y')
    #   image = image.polaroid (8 - rand(16)) do
    #     self.pointsize = 18
    #     self.gravity = Magick::CenterGravity
    #   end
    # 
    #   background = Magick::Image.new(image.columns, image.rows)
    #   image = background.composite(image, Magick::CenterGravity, Magick::OverCompositeOp)
    # end
    image.write("#{filename}")
    @file = File.new("#{filename}")
  end

  def original_filename
    @file.path
  end

  def respond_to?(method)
    super || @file.respond_to?(method)
  end

  def content_type
    "image/jpg"
  end

  def size
    File.size(@file.path)
  end

  def method_missing(name, *args)
    @file.send name, *args
  end
end