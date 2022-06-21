# Project 3 - *Twiddler*

**Twiddler** is a basic iOS app to read and compose tweets using the [Twitter API](https://apps.twitter.com/).

Time spent: **20** hours spent in total

## User Stories

The following **required** functionality is completed:

- [x] See an app icon in the home screen and a styled launch screen
- [x] Be able to log in using their Twitter account
- [x] See at latest the latest 20 tweets for a Twitter account in a Table View
- [x] Be able to refresh data by pulling down on the Table View
- [x] Be able to like and retweet from their Timeline view
- [x] Only be able to access content if logged in
- [x] Each tweet should display user profile picture, username, screen name, tweet text, timestamp, as well as buttons and labels for favorite, reply, and retweet counts.
- [x] Compose and post a tweet from a Compose Tweet view, launched from a Compose button on the Nav bar.
- [x] See Tweet details in a Details view
- [ ] App should render consistently all views and subviews in recent iPhone models and all orientations

The following **optional** features are implemented:

- [x] Be able to unlike or un-retweet by tapping a liked or retweeted Tweet button, respectively. (Doing so will decrement the count for each)
- [x] Click on links that appear in Tweets
- [ ] See embedded media in Tweets that contain images or videos
- [x] Reply to any Tweet. Replies should be prefixed with the username. The reply_id should be set when posting the tweet
- [x] See a character count when composing a Tweet (as well as a warning) (280 characters)
- [x] Load more tweets once they reach the bottom of the feed using infinite loading similar to the actual Twitter client
- [ ] Click on a Profile image to reveal another user’s profile page, including: Header view: picture and tagline and Basic stats: #tweets, #following, #followers
- [ ] Switch between timeline, mentions, or profile view through a tab bar
- [ ] Profile Page: pulling down the profile page should blur and resize the header image.

The following **additional** features are implemented:

- [x] UI improvements! 
  - [x] Round profile pictures
  - [x] Gray placeholder text when composing tweet that disappears when you start typing; tap to dismiss keyboard
  - [x] Character countdown turns red when you're over the limit
  - [x] Tweet timestamp in details view formatted with a little dot like in the Twitter app
- [x] User is asked to confirm logout after pressing the logout button.

Please list two areas of the assignment you'd like to **discuss further with your peers** during the next class (examples include better ways to implement something, how to extend your app in certain ways, etc):

1. It was hard for me to tell whether the GET/POST requests made for this app were syntax-specific in some ways to the Twitter API. It would be great to get more practice sending such requests to various other APIs.
2. Retweets from accounts I follow show up in my timeline. It would be nice to add the little gray tag at the top, as Twitter does, to indicate which account retweeted it. The method to do this wasn't obvious to me, so I didn't go down that road—I assume I would have to look more carefully at the Twitter API docs.

## Video Walkthrough

Here's a walkthrough of implemented user stories. The gifs showcase, in order:
1. Main walkthrough: All the required user stories besides login and autolayout, as well as untweeting & unfavoriting, tweets showing up without reload, infinite loading, tweet reply, and UI improvements.
2. Login and logout, which is accompanied by a confirmation alert to prevent accidental logout.
3. Clickable links in details view
4. Visual cues and alert when user tries to post a tweet that's too long
5. Autolayout demonstration, recorded on a real iPhone 12 Pro, which is why the phone borders are not visible (and there seems to be more whitespace on the left and right).

![twiddler_main](https://user-images.githubusercontent.com/43052066/124192858-f7f4df00-da93-11eb-93ca-4345c5abf075.gif)
![twiddler_loginlogout](https://user-images.githubusercontent.com/43052066/124195869-3e007180-da99-11eb-9d7e-607eb0c2b538.gif)

![twiddler_links](https://user-images.githubusercontent.com/43052066/124192877-fe835680-da93-11eb-8713-838aadb9c482.gif)
![twiddler_overload](https://user-images.githubusercontent.com/43052066/124192882-004d1a00-da94-11eb-878c-cb480dc9b09b.gif)


## Notes

Describe any challenges encountered while building the app.
1. A general challenge in building the app was that there weren't any more step-by-step videos, so there was a lot more personal research involved compared to the two prior apps. While this sometimes made me tentative to make changes in case they would break my code, I think it ultimately made for a more fulfilling educational experience.
2. For the replying-to-tweets functionality, I created a segue between the DetailsViewController and the ComposeViewController. However, in doing so, I accidentally bypassed the Navigation Controller that the ComposeViewController was embedded in. It took me a bit of time to realize what had happened, as the Compose Tweet screen that showed up when I hit the reply button would be missing the navigation bar (and thus the delete tweet and post tweet controls). (Thanks Eliel for helping me figure this out.)
3. Also when setting up the replying-to-tweets functionality, I changed the parameters dictionary to a NSMutableDictionary so that when replying to another tweet, I could pass in the additional argument to the Twitter API by adding a parameter to the dictionary. However, from the error console, it seemed that there was an error in adding parameters to the dictionary; the console referred to it as a "SingleElementDictionary" or something similar. So, I realized that I had to explicitly initiate the NSMutableDictionary with a capacity of 2 in order to fix this error.

## Credits

List an 3rd party libraries, icons, graphics, or other assets you used in your app.

- [AFNetworking](https://github.com/AFNetworking/AFNetworking) - networking task library
- [DateTools](https://github.com/MatthewYork/DateTools) - short "time ago" strings

## License

    Copyright 2021 Emily Jiang

    Licensed under the Apache License, Version 2.0 (the "License");
    you may not use this file except in compliance with the License.
    You may obtain a copy of the License at

        http://www.apache.org/licenses/LICENSE-2.0

    Unless required by applicable law or agreed to in writing, software
    distributed under the License is distributed on an "AS IS" BASIS,
    WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
    See the License for the specific language governing permissions and
    limitations under the License.
