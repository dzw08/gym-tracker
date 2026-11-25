# Gym Tracker App

![Flutter Badge](https://img.shields.io/badge/flutter-3.44.0-blue?logo=flutter)

![Dart Badge](https://img.shields.io/badge/dart-3.13.4-blue?logo=dart)

A gym tracker app intended for use in mobile environments written in Dart, using the Flutter framework.

Many people who lift weights regularly want to know whether they are getting stronger, but most track their training in a paper notebook, a notes app or from memory. These methods make it slow and error-prone to compare today's session with last week's, to work out how heavy a lift really is relative to a person's maximum, or to decide what weight to attempt next. Users also lose their records, forget what they lifted, and repeat the same exercise setup every session.

My solution is a mobile gym-tracker app. A user logs each set (weight, repetitions and RPE, the rate of perceived exertion on a 1-10 scale), and the app stores every session over time. It then:

shows previous reps and weights for each exercise,
graphs progress and projects it into the future,
estimates a one-rep max (1RM) using Epley's formula,
lets users save workout templates with exercises pre-selected, and
provides a rest timer between sets.

My target users are gym-goers of any age, who currently use paper notebooks or a general notes app but would like to see gym progress. They need this because there would usually not be any method to see past trends, one-rep-maxes, or store large volumes of sessions. Unlike a generic notes app, which stores text but understands nothing about it, my app is built around the structure of a workout.
