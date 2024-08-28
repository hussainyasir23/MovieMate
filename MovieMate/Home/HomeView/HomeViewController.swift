//
//  HomeViewController.swift
//  MovieMate
//
//  Created by Yasir on 16/09/23.
//

import UIKit
import FirebaseAuth

class HomeViewController: UIViewController {
    
    var presenter: HomePresenterProtocol?
    private var handle: AuthStateDidChangeListenerHandle?
    
    private var trendingMovies: [Movie] = []
    private var backDropViews: [CarouselItemView] = []
    
    private var nowPlayingMovies: [Movie] = []
    private var popularMovies: [Movie] = []
    private var topRatedMovies: [Movie] = []
    private var upcomingMovies: [Movie] = []
    
    private var selectedSegmentMovies: [Movie] = []
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.handle = Auth.auth().addStateDidChangeListener { auth, user in
            if let _ = user {
                
            }
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        Auth.auth().removeStateDidChangeListener(handle!)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.viewDidLoad()
        view.backgroundColor = ColorConstants.backgroundPrimary
        setupScrollView()
        setupPageControl()
        setupSegmentedControl()
        setupTableView()
    }
    
    private lazy var trendingScrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.delegate = self
        scrollView.isPagingEnabled = true
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.showsVerticalScrollIndicator = false
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    private lazy var trendingPageControl: UIPageControl = {
        let pageControl = UIPageControl()
        pageControl.backgroundColor = ColorConstants.backgroundPrimary
        pageControl.currentPageIndicatorTintColor = ColorConstants.contentPrimary
        pageControl.pageIndicatorTintColor = ColorConstants.contentTertiary
        pageControl.isUserInteractionEnabled = false
        pageControl.translatesAutoresizingMaskIntoConstraints = false
        return pageControl
    }()
    
    private lazy var listSegmentControl: UISegmentedControl = {
        let items = ["Now Playing", "Popular", "Top Rated", "Upcoming"]
        let segmentedControl = UISegmentedControl(items: items)
        segmentedControl.selectedSegmentIndex = 0
        segmentedControl.backgroundColor = ColorConstants.backgroundSecondary
        segmentedControl.selectedSegmentTintColor = ColorConstants.backgroundPrimary
        segmentedControl.addTarget(self, action: #selector(segmentChanged(_:)), for: .valueChanged)
        segmentedControl.translatesAutoresizingMaskIntoConstraints = false
        return segmentedControl
    }()
    
    private lazy var listTableView: UITableView = {
        let tableView = UITableView()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    private func setupScrollView() {
        view.addSubview(trendingScrollView)
        trendingScrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        trendingScrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        trendingScrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        trendingScrollView.heightAnchor.constraint(equalToConstant: ((self.view.bounds.width / 1280) * 720) + 26).isActive = true
    }
    
    private func setupPageControl() {
        view.addSubview(trendingPageControl)
        trendingPageControl.topAnchor.constraint(equalTo: trendingScrollView.bottomAnchor, constant: 8).isActive = true
        trendingPageControl.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    }
    
    private func setupCarousel() {
        
        trendingScrollView.contentSize = CGSize(width: self.view.bounds.width * CGFloat(trendingMovies.count),
                                                height: ((self.view.bounds.width / 1280) * 720) + 26)
        
        for (index, movie) in trendingMovies.enumerated() {
            let carouselItem = CarouselItemView(frame: CGRect(x: self.view.bounds.width * CGFloat(index),
                                                              y: 0,
                                                              width: self.view.bounds.width,
                                                              height: ((self.view.bounds.width / 1280) * 720) + 26))
            carouselItem.updateTitle(movie.title, rating: movie.voteAverage)
            backDropViews.append(carouselItem)
            presenter?.fetchBackDrop(for: movie)
            trendingScrollView.addSubview(carouselItem)
        }
        
        trendingPageControl.numberOfPages = trendingMovies.count
    }
    
    func setupSegmentedControl() {
        view.addSubview(listSegmentControl)
        listSegmentControl.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16).isActive = true
        listSegmentControl.topAnchor.constraint(equalTo: trendingPageControl.bottomAnchor, constant: 16).isActive = true
        listSegmentControl.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16).isActive = true
        selectedSegmentMovies = nowPlayingMovies
    }
    
    @objc func segmentChanged(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            selectedSegmentMovies = nowPlayingMovies
        case 1:
            selectedSegmentMovies = popularMovies
        case 2:
            selectedSegmentMovies = topRatedMovies
        case 3:
            selectedSegmentMovies = upcomingMovies
        default:
            break
        }
        listTableView.reloadData()
    }
    
    func setupTableView() {
        view.addSubview(listTableView)
        listTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16).isActive = true
        listTableView.topAnchor.constraint(equalTo: listSegmentControl.bottomAnchor, constant: 8).isActive = true
        listTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16).isActive = true
        listTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -8).isActive = true
    }
}

extension HomeViewController: HomeViewControllerProtocol {
    
    func displayTrendingMovies(_ trendingMovies: [Movie]) {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else {
                return
            }
            self.trendingMovies = trendingMovies
            setupCarousel()
        }
    }
    
    func failedToFetchTrendingMovies() {
        
    }
    
    func displayBackDrop(_ backDrop: UIImage, for movie: Movie) {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else {
                return
            }
            if let index = self.trendingMovies.firstIndex(where: { $0.id == movie.id }) {
                let carouselItem = self.backDropViews[index]
                carouselItem.updateBackDrop(backDrop)
            }
        }
    }
    
    func failedToFetchBackDrop(for movie: Movie) {
        
    }
    
    func displayNowPlayingMovies(_ nowPlayingMovies: [Movie]) {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else {
                return
            }
            self.nowPlayingMovies += nowPlayingMovies
            self.listTableView.reloadData()
        }
    }
    
    func failedToFetchNowPlayingMovies() {
        
    }
    
    func displayPoster(_ poster: UIImage, for movie: Movie) {
        
    }
    
    func failedToFetchPoster(for movie: Movie) {
        
    }
}

extension HomeViewController: UIScrollViewDelegate {
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let page = Int(scrollView.contentOffset.x / self.view.bounds.width)
        trendingPageControl.currentPage = page
    }
}

extension HomeViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return selectedSegmentMovies.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") ?? UITableViewCell(style: .default, reuseIdentifier: "cell")
        
        for view in cell.contentView.subviews {
            view.removeFromSuperview()
        }
        
        let titleLabel = UILabel()
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.text = selectedSegmentMovies[indexPath.row].title
        cell.contentView.addSubview(titleLabel)
        titleLabel.leadingAnchor.constraint(equalTo: cell.leadingAnchor).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo: cell.trailingAnchor).isActive = true
        titleLabel.topAnchor.constraint(equalTo: cell.topAnchor).isActive = true
        titleLabel.bottomAnchor.constraint(equalTo: cell.bottomAnchor).isActive = true
        return cell
    }
}
