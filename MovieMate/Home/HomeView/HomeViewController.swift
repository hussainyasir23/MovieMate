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
    private var backdropImageViews: [UIImageView] = []
    
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
    
    private func setupScrollView() {
        view.addSubview(trendingScrollView)
        trendingScrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        trendingScrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        trendingScrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        trendingScrollView.heightAnchor.constraint(equalToConstant: (self.view.bounds.width / 1280) * 720).isActive = true
    }
    
    private func setupPageControl() {
        view.addSubview(trendingPageControl)
        trendingPageControl.topAnchor.constraint(equalTo: trendingScrollView.bottomAnchor, constant: 8).isActive = true
        trendingPageControl.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    }
    
    private func setupCarousel() {
        
        DispatchQueue.main.async { [weak self] in
            
            guard let self = self else {
                return
            }
            
            self.trendingScrollView.contentSize = CGSize(width: self.view.bounds.width * CGFloat(trendingMovies.count),
                                                         height: (self.view.bounds.width / 1280) * 720)
            
            for (index, movie) in self.trendingMovies.enumerated() {
                let imageView = UIImageView(frame: CGRect(x: self.view.bounds.width * CGFloat(index),
                                                          y: 0,
                                                          width: self.view.bounds.width,
                                                          height: (self.view.bounds.width / 1280) * 720))
                
                imageView.image = UIImage(named: "placeholder")
                imageView.contentMode = .scaleAspectFit
                self.backdropImageViews.append(imageView)
                self.presenter?.fetchBackDrop(for: movie)
                self.trendingScrollView.addSubview(imageView)
            }
            
            self.trendingPageControl.numberOfPages = trendingMovies.count
        }
    }
}

extension HomeViewController: HomeViewControllerProtocol {
    
    func displayTrendingMovies(_ trendingMovies: [Movie]) {
        self.trendingMovies = trendingMovies
        setupCarousel()
    }
    
    func displayErrorInFetchingTrendingMovies() {
        
    }
    
    func displayBackDrop(_ backDrop: UIImage, for movie: Movie) {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else {
                return
            }
            if let index = self.trendingMovies.firstIndex(where: { $0.id == movie.id }) {
                let imageView = self.backdropImageViews[index]
                imageView.image = backDrop
            }
        }
    }
    
    func failedToFetchBackDrop(for movie: Movie) {
        
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
