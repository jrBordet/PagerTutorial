The UIPageViewController allows people to swipe left or right and cycle through a sequence of pages in an iOS app. Most examples of the UIPageViewController assume the use of Storyboards but sometimes could be necessary defining UI elements programmatically. 

This project discusses how to place a few pages in a PageViewController programmatically.

See the sample project on GitHub:

### Step 1: Create the PageViewController

```swift
/* Create the data source */

let colors: [UIColor] = [.red, .blue, .purple]

pages = colors.map { color -> PageViewController in
    return createPageViewController(of: color)
}

// Page view controller
pageViewController = UIPageViewController(transitionStyle: .scroll,
                                          navigationOrientation: .horizontal,
                                          options: nil)

// Set the delegate and datasource
pageViewController.delegate = self
pageViewController.dataSource = self

if let first = pages.first
{
    pageViewController.setViewControllers([first],
                                          direction: .forward,
                                          animated: true,
                                          completion: nil)
}
```


##### Add the pager view controller and the page control

```swift
// Display the pager programatically
dispalyContentController(of: pageViewController)

displayPageControl()
```

### Step 2: Display the pager view controller programmatically

```swift
func dispalyContentController(of content: UIViewController) {
    addChildViewController(content)

    content.view.frame = frameForContentController()

    view.addSubview(pageViewController.view)

    content.didMove(toParentViewController: self)
}
```

#### Step 3: Add the page control

```swift
func displayPageControl() {
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
```

### Step 4: Implement DataSource to handle user swipe

```swift
extension ViewController: UIPageViewControllerDataSource {
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {

        if let viewControllerIndex = pages.index(of: viewController as! PageViewController) {
            if viewControllerIndex != 0 {
                return pages[viewControllerIndex - 1]
        }
        return nil
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {

        if let viewControllerIndex = pages.index(of: viewController as! PageViewController) {
            if viewControllerIndex < pages.count - 1 {
                return pages[viewControllerIndex + 1]
            }
        }
        return nil
    }
    
}
```

### Step 5: Update the UIPageControl

```swift
// MARK: UIPageViewControllerDelegate

extension ViewController: UIPageViewControllerDelegate {
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        
        if let viewControllers = pageViewController.viewControllers {
            if let viewControllerIndex = pages.index(of: viewControllers.first as! PageViewController) {

                pageControl.currentPage = viewControllerIndex

            }
        }
    }
    
}
```
