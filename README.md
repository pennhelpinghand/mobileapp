## Inspiration
Nicotine addiction is an epidemic that is taking the nation in millions due to the growing popularity of "E-Cigarettes." This has affected over 50 million people in the U.S. alone including our friends, family, and loved ones. 90% of these users started smoking before reaching 20 years old. Since the outbreak of trendy E-Cig companies like JUUL and Suorin, the number of high schoolers smoking spiked by 71% in just 2 years. With this problem heavily affecting our generation and generations to come, we want to propose, HelpingHand, a solution that could help mitigate the detrimental effects we noticed.

## What it does
HelpingHand aims to combat this problem by utilizing FitBit's to detect when drug abusers experience withdrawal symptoms throughout their rehabilitation process. HelpingHand emphasizes the importance of positive reinforcement, peer support, and community in helping those struggling to quit, actually quit. Our advanced technology detects when the drug abuser is experiencing stress, therefore a high probability of nicotine relapse and notify their loved ones to provide a helping hand.

## How we built it
Fitbit SDK for the Fitbit app and sending REST calls to the iOS app.
Flutter and Dart for the iOS app and to receive REST calls.
Express.JS for Twilio API, communication between the Fitbit data on the phone and Firebase.
Firebase for an intermediary server through which our platforms can communicate.
Java, org.json to create mock JSON containing timestamps, heartbeat rate, number of steps taken.
And lots and lots of coffee!

## Challenges we ran into
Due to our unfamiliarity with the Fitbit API, an initial challenge we ran into was figuring out how to collect the intraday time-series heart rate data from the Fitbit. Cross-platform communication between the Fitbit and our iOS Flutter app proved to be rather difficult, but once we overcame that hurdle things became much easier.

Our team also spent a significant amount of time with research on smoking and its health effects, particularly the effect it has on heart beat rate and heart beat variability. Unfortunately, there is no publicly available dataset containing heart rate for individuals attempting to quit smoking. 

After interviewing people who have experienced nicotine withdrawals in the past, we discovered that high levels of anxiety will greatly increase a smoker's urge to relapse. It was from here that we began to think of the core aspects of HelpingHand and to start building the app.

## Accomplishments that we're proud of
We're surprised at ourselves as to how much all learned this weekend! There were many different API's, frameworks, and hardware we weren't entirely comfortable with and having the opportunity to challenge ourselves was a ton of fun. We're especially proud of the fact that we have been able to finish -- and get working -- the core, defining aspects of HelpingHand.

Every one of the team members personally knows someone who has suffered or is currently suffering from nicotine addiction. _By leveraging existing technologies such as the Fitbit, we sincerely hope that HelpingHand will positively impact the substance abuse epidemic in the United States._

**However, HelpingHand's mission doesn't stop at PennApps. We're committed to extending the app to other substances such as opioids, as well as mental health with depression-related anxiety hacks.**

## What we learned
We fiddled a ton with the Fitbit SDK, and learned how to make Fitbit apps! Communication across the different platforms -- between Fitbit, our mobile app, Firebase, and Twilio was challenging but incredibly rewarding. In addition to the technology, a big takeaway from this is the immense knowledge we gained about drug abuse, rehabilitation, and recovery. From the personal stories we shared, to the case studies we discovered, this was truly a great opportunity to learn through real-world application.

## What's next for HelpingHand
We would like to scale our app so that people across the world can get help coping with nicotine addiction. It would also enable for an expansive, online support community. We know "machine learning" gets tossed around a lot, but utilizing it to minimize false positives would be super promising. 

Moreover, only a portion of smart watch wearers use FitBit. An integration of HelpingHand to more health watches such as the Apple Watch would make our app more accessible.

We also spent time debating on whether to tackle nicotine addiction or depression-related anxiety attacks during this weekend. While we opted for nicotine addiction, we believe extending HelpingHand to depression and other abused substances will open the door for many more applications.
