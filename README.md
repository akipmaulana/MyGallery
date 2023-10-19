# MyGallery
Gallery App Using API from Art Institute of Chicago API. There are 4 main feature on gallery screen.

- Fetch artwork collection
- Pagination fetching
- Refreshable collection
- Search artwork

## Challenge
Populating data on artwork gallery screen should displayed the image using formatted url that compoosed by following step

- Retrieve one or more artworks with image_id fields through API Request
- Find the base IIIF Image API endpoint in the `config.iiif_url`
- Append the `image_id` of the artwork as a segment to this URL
- Append `/full/843,/0/default.jpg` to the URL

Those steps would be executed for each item asynchrounously, so that user interaction work as usual smoothly.

## How to Run Program
Simply clone this repo and open `MyGallery.xcodeproj`
- Choose Device Targe
- Click Run

## Code Coverage
Code has covered by unit test with percentage about 73%

![code_coverage](https://raw.githubusercontent.com/akipmaulana/MyGallery/main/Example/code_coverage.png)

## Result
| Positive Search | Negative Search | Populated |
| :---:   | :---: | :---: |
| ![poopulated](https://raw.githubusercontent.com/akipmaulana/MyGallery/main/Example/positive_search.png) | ![poopulated](https://raw.githubusercontent.com/akipmaulana/MyGallery/main/Example/negative_search.png)   | ![poopulated](https://raw.githubusercontent.com/akipmaulana/MyGallery/main/Example/populated.png) |

