Mussle - Music Sliding Puzzle

## Inspiration
I wanted to change Sliding Puzzle game into 3D, like FEZ game. It seemed to be a bit too challenging for a first Flutter project though. I realized, I can make the app to utilize in another "dimension" - sound. It became quite obvious how to connect music with sliding puzzle - although unexpected result was the educational aspect - you can learn sounds by heart with the Mussle.

## What it does
Mussle help you to create music intuition of how the particular note sounds. Firstly, you listen to the melody, then you try to reflect it, by moving notes in the expected notes order. The simple tutorial helps you to grasp the idea. There are 3 levels and two simple melodies so far. Later levels does not have every note denoted, like `G` or `F#` - you have to figure them out.

## How I built it
I started in the middle of January, but until the end of the month I've got almost no code. So I created a habit of spending at least 1 hour every day on the project or learning Flutter.

## Challenges I ran into
The most challenging part was to finish the project before 28 of February because of the outbreak of war in Ukraine. It was mentally challenging to focus on anything else for quite a few days.

I've got some many small technical challenges - for every such case I had to stop code project and learn Flutter - almost always worked. Exception was, when I couldn't do everything I wanted with [GetX](https://pub.dev/packages/get) library (state management) - animation state management didn't work there - I switched to `StatefulWidget`. I also didn't find good audio library which supports all platforms. The [Audioplayers](https://pub.dev/packages/audioplayers) one does not fully support web - for instance. So I decided to build the app for Android and iOS.

The design was bit challenging too. I'm not good at it, but what I proposed is, I hope, at least elegant.

## Accomplishments that I'm proud of
I'm proud of number of lines of codes my project has. Not so many, which is great :-) The code is also quite clean. I'm also proud of small things, like sound animation after `double tap` on a tile, or possibility to easily add new levels to the Mussle!

## What I learned
I learned that GetX is very simple, but doesn't work well with animations. The most important lesson though, once again: create a habit and follow it.

## What's next for Mussle
I do think this project, in different shape, has a future. I should change a design from sliding puzzle to something more suitable to music, cause it requires so many tile moves to finish the game! I'd add some well-known melodies everybody knows in new levels. Also different variants of the game, like "learning mode" - to learn musical scales in an efficient way. Even the possibility to create your own level for a friend. Last, not least, compelling design.