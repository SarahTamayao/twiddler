# Project 3 - *Twiddler*

**Twiddler** is a basic iOS app to read and compose tweets using the [Twitter API](https://apps.twitter.com/).

Time spent: **20** hours spent in total

## User Stories

The following **required** functionality is completed:

- [x] User sees app icon in home screen and styled launch screen
- [x] User can sign in using OAuth login flow
- [x] User can Logout
- [x] User can view last 20 tweets from their home timeline
- [x] In the home timeline, user can view tweet with the user profile picture, username, tweet text, and timestamp.
- [x] User can pull to refresh.
- [x] User can tap the retweet and favorite buttons in a tweet cell to retweet and/or favorite a tweet.
- [x] User can compose a new tweet by tapping on a compose button.
- [x] Using AutoLayout, the Tweet cell should adjust its layout for iPhone 11, Pro and SE device sizes as well as accommodate device rotation.
- [x] User should display the relative timestamp for each tweet "8m", "7h"
- [x] Tweet Details Page: User can tap on a tweet to view it, with controls to retweet and favorite.

The following **optional** features are implemented:

- [ ] User can view their profile in a *profile tab*
  - Contains the user header view: picture and tagline
  - Contains a section with the users basic stats: # tweets, # following, # followers
  - [ ] Profile view should include that user's timeline
- [x] User should be able to unretweet and unfavorite and should decrement the retweet and favorite count. Refer to [[this guide|unretweeting]] for help on implementing unretweeting.
- [x] \*Links in tweets are clickable. Yes, but only in the details view. I had to replace the UILabel with a UITextView, which meant that I had to redo all the Auto Layout constraints. I didn't bother doing this again on the timeline screen because the tweet cells there had more complex constraints that I had already set up. In the future, if I know I want the text block to recognize links, I will construct it with a UITextView from the start to avoid resetting all the constraints.
- [ ] User can tap the profile image in any tweet to see another user's profile
  - Contains the user header view: picture and tagline
  - Contains a section with the users basic stats: # tweets, # following, # followers
- [x] User can load more tweets once they reach the bottom of the feed using infinite loading similar to the actual Twitter client. 
- [x] When composing, you should have a countdown for the number of characters remaining for the tweet (out of 280) (**1 point**)
- [x] After creating a new tweet, a user should be able to view it in the timeline immediately without refetching the timeline from the network.
- [x] User can reply to any tweet, and replies should be prefixed with the username and the reply_id should be set when posting the tweet (**2 points**)
- [ ] User sees embedded images in tweet if available
- [ ] \*User can switch between timeline, mentions, or profile view through a tab bar (**3 points**) I did implement a tab bar as seen in the 2nd gif below, but only the timeline tab is functional. 
- [ ] Profile Page: pulling down the profile page should blur and resize the header image. (**4 points**)


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
![twiddler_autorotate](https://user-images.githubusercontent.com/43052066/124193956-b7966080-da95-11eb-8116-933121cd5585.gif)

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
