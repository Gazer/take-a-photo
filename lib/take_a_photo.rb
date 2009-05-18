class TakeAPhoto
  def initialize(request)
    file = Tempfile.new('take_a_photo')
    filename = "#{file.path}.jpg"
    file.close

    @file = Magick::Image.from_blob(request.body.read).first
    @file.write(filename)    

    @file = File.new filename
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