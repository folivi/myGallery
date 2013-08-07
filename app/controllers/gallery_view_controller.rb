class GalleryViewController < UICollectionViewController
  attr_accessor :photos
  def loadView
    super
    @photos = []
    @pictures = []
    self.photos = []    
    @pictures = get_pictures()    
    puts "called"
  end
  def viewDidLoad
    super
    self.collectionView.backgroundColor = UIColor.whiteColor
    collectionView.dataSource = self    
    collectionView.registerClass(Cell, forCellWithReuseIdentifier:"MY_CELL")    
  end

  # UICollectionViewDataSource
  def collectionView(view, numberOfItemsInSection:section)
    puts "self.photos.count #{self.photos.count} \n"
    self.photos.count    
  end

  def collectionView(view, cellForItemAtIndexPath:path)
    cell = view.dequeueReusableCellWithReuseIdentifier("MY_CELL", forIndexPath:path)    
    #cell.imageView.image = self.photos[path.item]
    cell
  end
  def get_pictures
    puts "get_pictures"
    url ="http://mambotime.lu/galleries.json"
    BW::HTTP.get url do |response|
      json = BW::JSON.parse response.body.to_str
      for line in json                  
        @pictures << line["picture"]["thumb"]["url"]
      end   
    end
    @pictures
  end
end