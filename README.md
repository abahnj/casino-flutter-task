# Casino Test

Test Task: Online Casino Flutter application.

Do you remember Rick and Morty cartoon? 
Your goal is to create the app with all the characters from this cartoon, and make it look juicy.

API docs: https://rickandmortyapi.com/documentation

## To-do:

Using clean architecture design pattern
- [x] Refactor application to your best understanding of the design pattern
- [x] Fix loading state and fetching data feature
- [x] Find and fix all other bugs and issues
- [x] Add more information about characters
- [x] Optimize scrolling performance
- [x] Implement pagination

## Optional:
Implement pagination
- [x] Add infinite scrolling pagination
- [x] Implement recovering from an `Error` state after the last request failed in the paginated view (i.e Application should be able to make a request and return a success response when the previous request fails. 
- [x] Account for all possible states and edge cases
    - [x] Initial
    - [x] Loading
        - [x] Initial loading state (when fetching the first page)
        - [x] Next page loading state (when fetching the next page after previous pages has been fetched successfully)
    - [x] Success
    - [x] Error 
        - [x] Initial error state (when fetching the first page)
        - [x] Next page error state (when fetching the next page after previous pages has been fetched successfully)

## Bonus:
- [x] Added tests

## Things to keep in mind
- You need to use same libraries, but you can also add more (reasonable amount)
    ### Added Libraries
    - cached_network_image - for remote image caching
    - bloc_concurrency - to avoid repeating ongoing requests
    - bloc_test
    - flutter_lints
    - mocktail

- Simulate a failure case by turning off your internet connection and a success case by turning on your internet connection.
- Your code should compile without errors and app should run on both iOS and Android seamlessly
- Keep things clean, simple and fun
- Use bloc state-management if possible
- You can fork or clone the repo and share the link (make sure it is public and accessible) 
