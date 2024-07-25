import UIKit

class get_started: UIViewController, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    var window: UIWindow?
    
    let images = ["1", "2", "3"] // Names of your images
    let screenTexts = ["Move your body, Shape your future", "You cannot enjoy your wealth, if you cannot enjoy your health", "Every day is another chance to get stronger, to eat better, to live healthier, and to be the best version of you."] // Texts for each screen
    let screenTextsBN = ["আপনার রাইড পরীক্ষা করুন", "সহজ বুকড", "রাইড উপভোগ করুন"] // Texts for each screen in bangla
    
    let newScreenTexts = ["Goals & Fitness", "Easy to Use", "Tracks Health Records"]
    
    let backgroundImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.image = UIImage(named: "Background")
        return imageView
    }()

    let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.isPagingEnabled = true
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.backgroundColor = .clear
        return collectionView
    }()

    let pageControl: UIPageControl = {
        let pageControl = UIPageControl()
        pageControl.translatesAutoresizingMaskIntoConstraints = false
        pageControl.currentPageIndicatorTintColor = .black
        pageControl.pageIndicatorTintColor = .lightGray
        return pageControl
    }()

    let previousButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitleColor(.blue, for: .normal)
        return button
    }()

    let nextButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitleColor(.blue, for: .normal)
        return button
    }()

    let getStartedButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .blue
        button.layer.cornerRadius = 10
        return button
    }()

    let screenTextLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 12, weight: .light)
        label.textColor = .black
        label.numberOfLines = 0 // Allows for multiple lines
        label.lineBreakMode = .byWordWrapping // Ensures the text wraps correctly
        return label
    }()

    let newScreenTextLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        label.textColor = .purple
        label.numberOfLines = 0 // Allows for multiple lines
        label.lineBreakMode = .byWordWrapping // Ensures the text wraps correctly
        return label
    }()

    let topLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 28, weight: .bold)
        label.textColor = .black
        return label
    }()

    let closeButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(named: "language_white"), for: .normal) // Set your close button image here
        button.addTarget(self, action: #selector(closeButtonTapped(_:)), for: .touchUpInside)
        return button
    }()
    
    var currentImageIndex = 0

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        // Add the background image view
        view.addSubview(backgroundImageView)
        
        // Set up collection view
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(ImageCell.self, forCellWithReuseIdentifier: "Cell")
        view.addSubview(collectionView)
        
        // Set up page control
        pageControl.numberOfPages = images.count
        pageControl.addTarget(self, action: #selector(pageControlValueChanged(_:)), for: .valueChanged)
        view.addSubview(pageControl)
        
        // Set up previous button
        previousButton.addTarget(self, action: #selector(previousButtonTapped(_:)), for: .touchUpInside)
        view.addSubview(previousButton)
        
        // Set up next button
        nextButton.addTarget(self, action: #selector(nextButtonTapped(_:)), for: .touchUpInside)
        view.addSubview(nextButton)
        
        // Set up get started button
        view.addSubview(getStartedButton)
        
        // Set up screen text label
        screenTextLabel.text = screenTexts[currentImageIndex]
        view.addSubview(screenTextLabel)
        
        // Set up new screen text label
        newScreenTextLabel.text = newScreenTexts[currentImageIndex]
        view.addSubview(newScreenTextLabel)
        
        // Set up top label
        view.addSubview(topLabel)
        
        // Add the close button
        view.addSubview(closeButton)
        
        // Send the background image view to the back
        view.sendSubviewToBack(backgroundImageView)
        
        // Set up constraints
        NSLayoutConstraint.activate([
            backgroundImageView.topAnchor.constraint(equalTo: view.topAnchor),
            backgroundImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            backgroundImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            backgroundImageView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            topLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            topLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            collectionView.topAnchor.constraint(equalTo: topLabel.bottomAnchor, constant: 20),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: newScreenTextLabel.topAnchor, constant: -20),
            
            newScreenTextLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            newScreenTextLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            newScreenTextLabel.bottomAnchor.constraint(equalTo: screenTextLabel.topAnchor, constant: -20),
            
            screenTextLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            screenTextLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            screenTextLabel.bottomAnchor.constraint(equalTo: getStartedButton.topAnchor, constant: -20),
            
            getStartedButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            getStartedButton.bottomAnchor.constraint(equalTo: pageControl.topAnchor, constant: -20),
            getStartedButton.widthAnchor.constraint(equalToConstant: 200),
            getStartedButton.heightAnchor.constraint(equalToConstant: 50),
            
            pageControl.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            pageControl.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -20),
            
            previousButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            previousButton.centerYAnchor.constraint(equalTo: pageControl.centerYAnchor),
            
            nextButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            nextButton.centerYAnchor.constraint(equalTo: pageControl.centerYAnchor),
            
            closeButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            closeButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            closeButton.widthAnchor.constraint(equalToConstant: 30), // Adjust width as needed
            closeButton.heightAnchor.constraint(equalToConstant: 30) // Adjust height as needed
        ])
        
        previousButton.setTitle("Previous", for: .normal)
        topLabel.text = "Get Started Now"
        getStartedButton.setTitle("Get Started Now", for: .normal)
        nextButton.setTitle("Next", for: .normal)
        self.getStartedButton.addTarget(self, action: #selector(get_started_now_click_method), for: .touchUpInside)
        
        /*if let remember_me = UserDefaults.standard.string(forKey: "key_remember_me") {
            print(remember_me as Any)
            
            if remember_me == "yes" {
                self.remember_me()
            }
        } else {
            self.push_to_home_page()
        }*/
        self.remember_me()
    }
    
    @objc func remember_me() {
        
        if let person = UserDefaults.standard.value(forKey: str_save_login_user_data) as? [String:Any] {
            print(person as Any)
            
            if person["role"] as! String == "Member" {
                
                if (person["gender"] as! String) == "" {
                    
                    let push = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "complete_profile_id")
                    self.navigationController?.pushViewController(push, animated: true)
                    
                } else if (person["Fitness_goal"] as! String) == "" {
                    
                    let push = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "complete_profile_two_id")
                    self.navigationController?.pushViewController(push, animated: true)
                    
                } else if (person["food_preference"] as! String) == "" {
                    
                    let push = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "complete_profile_three_id")
                    self.navigationController?.pushViewController(push, animated: true)
                    
                } else {
                    
                    // push to dashboard
                    let push = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "dashboard_id")
                    self.navigationController?.pushViewController(push, animated: true)
                    
                }
                
                
                
            } else {
                debugPrint("")
                // DRIVER
                // let push = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "dashboard_id")
                // self.navigationController?.pushViewController(push, animated: true)
                
            }
            
        }
        
    }
    
    @objc func closeButtonTapped(_ sender: UIButton) {
        print("Close button tapped")
    }
    
    @objc func get_started_now_click_method() {
        print("Start button tapped")
        UserDefaults.standard.set("yes", forKey: "key_remember_me")
        self.push_to_home_page()
    }
    
//    @objc func remember_me() {
//        self.push_to_home_page()
//    }
    
    @objc func push_to_home_page() {
        let push = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "login_id") as? login
        self.navigationController?.pushViewController(push!, animated: true)
    }
    
    @objc func pageControlValueChanged(_ sender: UIPageControl) {
        let indexPath = IndexPath(item: sender.currentPage, section: 0)
        collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
        currentImageIndex = sender.currentPage
        screenTextLabel.text = screenTexts[currentImageIndex]
        newScreenTextLabel.text = newScreenTexts[currentImageIndex]
        screenTextLabel.layoutIfNeeded() // Ensure the label is laid out correctly
        newScreenTextLabel.layoutIfNeeded() // Ensure the label is laid out correctly
    }
    
    @objc func previousButtonTapped(_ sender: UIButton) {
        if currentImageIndex > 0 {
            currentImageIndex -= 1
            let indexPath = IndexPath(item: currentImageIndex, section: 0)
            collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
            pageControl.currentPage = currentImageIndex
            screenTextLabel.text = screenTexts[currentImageIndex]
            newScreenTextLabel.text = newScreenTexts[currentImageIndex]
            screenTextLabel.layoutIfNeeded() // Ensure the label is laid out correctly
            newScreenTextLabel.layoutIfNeeded() // Ensure the label is laid out correctly
        }
    }
    
    @objc func nextButtonTapped(_ sender: UIButton) {
        if currentImageIndex < images.count - 1 {
            currentImageIndex += 1
        } else {
            currentImageIndex = 0
        }
        let indexPath = IndexPath(item: currentImageIndex, section: 0)
        collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
        pageControl.currentPage = currentImageIndex
        screenTextLabel.text = screenTexts[currentImageIndex]
        newScreenTextLabel.text = newScreenTexts[currentImageIndex]
        screenTextLabel.layoutIfNeeded() // Ensure the label is laid out correctly
        newScreenTextLabel.layoutIfNeeded() // Ensure the label is laid out correctly
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let pageIndex = Int(scrollView.contentOffset.x / scrollView.frame.width)
        currentImageIndex = pageIndex
        pageControl.currentPage = pageIndex
        screenTextLabel.text = screenTexts[currentImageIndex]
        newScreenTextLabel.text = newScreenTexts[currentImageIndex]
        screenTextLabel.layoutIfNeeded() // Ensure the label is laid out correctly
        newScreenTextLabel.layoutIfNeeded() // Ensure the label is laid out correctly
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! ImageCell
        cell.imageView.image = UIImage(named: images[indexPath.item])
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
    }
}

class ImageCell: UICollectionViewCell {
    
    let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(imageView)
        
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            imageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

