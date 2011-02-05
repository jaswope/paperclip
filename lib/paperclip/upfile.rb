require 'filemagic'
module Paperclip
  # The Upfile module is a convenience module for adding uploaded-file-type methods
  # to the +File+ class. Useful for testing.
  #   user.avatar = File.new("test/test_avatar.jpg")
  module Upfile

    # Infer the MIME-type of the file from the extension.
    def content_type
      FileMagic.mime.file(self.path, true)      
    end

    # Returns the file's normal name.
    def original_filename
      File.basename(self.path)
    end

    # Returns the size of the file.
    def size
      File.size(self)
    end
  end
end

if defined? StringIO
  class StringIO
    attr_accessor :original_filename, :content_type, :fingerprint
    def original_filename
      @original_filename ||= "stringio.txt"
    end
    def content_type
      @content_type ||= "text/plain"
    end
    def fingerprint
      @fingerprint ||= Digest::MD5.hexdigest(self.string)
    end
  end
end

class File #:nodoc:
  include Paperclip::Upfile
end
