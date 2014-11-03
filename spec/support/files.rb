RSpec.configure do |config|

  # Usage:
  # drop_files 'aaa.png', 'bbb.jpg', 'ccc.wtf', to: 'div[data-attachment=hoverzone]'
  # And don't forget to place the files into spec/support/images/
  # You may want to `wait_for_ajax` afterwards
  def drop_files(*files)
    drop_area_selector = files.extract_options!.fetch(:to)

    js_script = "fileList = Array();"
    photos_path(files).each_with_index do |fn, i|
      # Generate a fake input selector
      page.execute_script("if ($('#fakeUpload#{i}').length == 0) { fakeUpload#{i} = window.$('<input/>').attr({id: 'fakeUpload#{i}', type:'file'}).appendTo('body'); }")
      # Attach file to the fake input selector through Capybara
      attach_file("fakeUpload#{i}", fn)
      # Build up the fake js event
      js_script = "#{js_script} fileList.push(fakeUpload#{i}.get(0).files[0]);"
    end

    # Trigger the fake drop event
    page.execute_script("#{js_script} e = $.Event('drop'); e.originalEvent = {dataTransfer : { files : fileList } }; $('#{drop_area_selector}').trigger(e);")

  end

  def photo_path(filename)
    Rails.root.join('spec', 'support', 'images', filename)
  end

  def photos_path(filenames)
    filenames.map { |fn| photo_path(fn) }
  end

  def get_photo(filename)
    File.open photo_path(filename)
  end

  def get_file(*args)
    get_photo(*args)
  end

end
