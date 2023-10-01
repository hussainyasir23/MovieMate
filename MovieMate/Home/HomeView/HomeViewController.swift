//
//  HomeViewController.swift
//  MovieMate
//
//  Created by Yasir on 16/09/23.
//

import UIKit
import FirebaseAuth

class HomeViewController: UIViewController, HomeViewControllerProtocol, UIScrollViewDelegate {
    
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
    
    private let scrollView = UIScrollView()
    private let pageControl = UIPageControl()
    
    private func setupScrollView() {
        scrollView.delegate = self
        scrollView.isPagingEnabled = true
        scrollView.showsHorizontalScrollIndicator = false
        view.addSubview(scrollView)
        
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.heightAnchor.constraint(equalToConstant: 200)
        ])
    }
    
    private func setupPageControl() {
        view.addSubview(pageControl)
        
        pageControl.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            pageControl.topAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: 10),
            pageControl.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        pageControl.tintColor = ColorConstants.contentTertiary
        pageControl.currentPageIndicatorTintColor = ColorConstants.contentPrimary
        pageControl.backgroundColor = ColorConstants.backgroundSecondary
        pageControl.isUserInteractionEnabled = false
    }
    
    private func setupCarousel() {
        DispatchQueue.main.async { [weak self] in
            
            guard let self = self else {
                return
            }
            self.scrollView.contentSize = CGSize(width: self.view.bounds.width * CGFloat(trendingMovies.count), height: 200)
            
            for (index, movie) in self.trendingMovies.enumerated() {
                let imageView = UIImageView(frame: CGRect(x: self.view.bounds.width * CGFloat(index),
                                                          y: 0,
                                                          width: self.view.bounds.width,
                                                          height: 200))
                
                imageView.image = UIImage(named: "placeholder")
                imageView.contentMode = .scaleAspectFit
                self.backdropImageViews.append(imageView)
                self.presenter?.fetchBackDrop(for: movie)
                self.scrollView.addSubview(imageView)
            }
            
            self.pageControl.numberOfPages = trendingMovies.count
        }
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let page = Int(scrollView.contentOffset.x / self.view.bounds.width)
        pageControl.currentPage = page
    }
}
