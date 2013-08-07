class GalleryViewController < UICollectionViewController
  attr_accessor :photos
  def loadView
    super
    @photos = []
    get_pictures()
    self.photos = []    
    puts "called"
  end
  def viewDidLoad
    super
    collectionView.registerClass(Cell, forCellWithReuseIdentifier:"MY_CELL")    
#    dir = NSBundle.mainBundle.bundlePath
#    Dir.glob(File.join(dir, "*.jpg")) do |file|
#      @photos << UIImage.imageNamed(File.basename(file))
#    end
  end

  # UICollectionViewDataSource
  def collectionView(view, numberOfItemsInSection:section)
    puts "@photos.count #{@photos.count} \n"
    @photos.count
  end

  def collectionView(view, cellForItemAtIndexPath:path)
    cell = view.dequeueReusableCellWithReuseIdentifier("MY_CELL", forIndexPath:path)    
    #cell.imageView.image = self.photos[path.item]
    cell
  end
  def get_pictures #(empty_array)
    @pictures = []
    url ="http://mambotime.lu/galleries.json"
    base_url = "http://mambotime.lu/"
    BW::HTTP.get url do |response|
      json = BW::JSON.parse response.body.to_str
      for line in json          
        @pictures << line["picture"]["thumb"]["url"]
        self.photos << line["picture"]["thumb"]["url"]        
      end
    end
    @pictures      
  end  
end