//
//  PageViewModel.swift
//  PagerTutorial
//
//  Created by Jean Raphael on 02/02/2018.
//  Copyright © 2018 Jean Raphael Bordet. All rights reserved.
//

import UIKit

class PageViewModel: NSObject {
    var pages: [UIViewController]
    let pageControl: UIPageControl

    init(_ pages: [PageViewController], pageControl: UIPageControl) {
        self.pages = pages
        self.pageControl = pageControl        
    }
    
}

extension PageViewModel: UIPageViewControllerDataSource {
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        if let viewControllerIndex = pages.index(of: viewController ) {
            if viewControllerIndex == 0 {
                return pages.last
            } else {
                return pages[viewControllerIndex - 1]
            }
        }
        return nil
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        if let viewControllerIndex = pages.index(of: viewController ) {
            if viewControllerIndex < pages.count - 1 {
                return pages[viewControllerIndex + 1]
            } else {
                return pages.first
            }
        }
        return nil
    }
    
    
}

extension PageViewModel: UIPageViewControllerDelegate {
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        if let viewControllers = pageViewController.viewControllers {
            if let first = viewControllers.first, let viewControllerIndex = pages.index(of: first) {
                pageControl.currentPage = viewControllerIndex
            }
        }
    }
    
    
}

