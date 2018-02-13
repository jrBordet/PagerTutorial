//
//  ViewController.swift
//  PagerTutorial
//
//  Created by Jean Raphael on 01/02/2018.
//  Copyright © 2018 Jean Raphael Bordet. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    var pageViewController: UIPageViewController!
    let pageControl = UIPageControl()
    
    var pages = [PageViewController]()
    let colors: [UIColor] = [.red, .blue, .purple, .lightGray]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Create data source
        pages = colors.map { color -> PageViewController in
            return createPageViewController(of: color)
        }
        
        // Page view controller
        pageViewController = UIPageViewController(transitionStyle: .scroll,
                                                  navigationOrientation: .horizontal,
                                                  options: nil)

        pageViewController.delegate = self
        pageViewController.dataSource = self

        if let first = pages.first
        {
            pageViewController.setViewControllers([first],
                                                  direction: .forward,
                                                  animated: true,
                                                  completion: nil)
        }

        // Display the pager programatically
        dispalyContentController(of: pageViewController)

        displayPageControl()
    }

    // MARK: Display page view controller
    
    func dispalyContentController(of content: UIViewController) {
        addChildViewController(content)

        content.view.frame = frameForContentController()

        view.addSubview(pageViewController.view)

        content.didMove(toParentViewController: self)
    }
    
    func displayPageControl() {
        // Create the page control
        pageControl.numberOfPages = pages.count
        
        pageControl.currentPage = 0
        
        pageControl.frame = CGRect()
        
        pageControl.currentPageIndicatorTintColor = .white
        pageControl.pageIndicatorTintColor = .lightGray
        
        pageControl.numberOfPages = pages.count
        
        pageControl.currentPage = 0
        
        view.addSubview(pageControl)

        pageControl.translatesAutoresizingMaskIntoConstraints = false
        pageControl.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -15).isActive = true
        pageControl.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -20).isActive = true
        pageControl.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    }
    
    func frameForContentController() -> CGRect {
        return UIScreen.main.bounds
    }
    
    // MARK: - Privates
    
    func createPageViewController(of color: UIColor) -> PageViewController {
        let result = PageViewController()
        
        result.view.backgroundColor = color
        
        return result
    }

    
}

// MARK: UIPageViewControllerDataSource

extension ViewController: UIPageViewControllerDataSource {
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        if let index = pages.index(of: viewController as! PageViewController) {
            if index != 0 {
                return pages[index - 1]
            }
        }
        return nil
    }

    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        if let index = pages.index(of: viewController as! PageViewController) {
            if index < pages.count - 1 {
                return pages[index + 1]
            }
        }
        return nil
    }
    

}

// MARK: UIPageViewControllerDelegate

extension ViewController: UIPageViewControllerDelegate {
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        if let viewControllers = pageViewController.viewControllers {
            if let index = pages.index(of: viewControllers.first as! PageViewController) {
                pageControl.currentPage = index
            }
        }
    }


}

