# README

## Installation
*prerequisite: have rails installed on your machine*
1. Clone the repo
2. run `bundle install` in the project folder
3. run `rails server` (still in project folder)
4. Go to `http://localhost:3000`

## How to
Once you are on `http://localhost:3000` you should see a small form with 2 inputs:
- upload .csv file
- upload date of the recording (optional but better for detailed results :thumbsup:)

Then submit the form and you should see the results of the delineation analysis !

## Some remarks
- The front is very (very) basic, could definitely be improved :nail_care:
- Tests are not complete :construction_worker:

## Assignment
Holter Record Summary

A normal heartbeat produces three entities on the ECG — a P wave, a QRS complex, a T wave.
https://en.wikipedia.org/wiki/Electrocardiography#Theory
Identifying those entities in a signal is called delineation.

Here are CSV of an algorithm output for a 24h ECG: https://cardiologs-public.s3.amazonaws.com/python-interview/record.csv

Rows have the following fields:
Wave type: P, QRS, T, or INV (invalid)
Wave onset: Start of the wave in ms
Wave offset: End of the wave in ms
Optionally, a list of wave tags
Write a simple application, including a web interface and an HTTP server with the following functionalities:

1. Providing the following measurements to a physician when a delineation file is uploaded on the app with a POST /delineation request:
   The mean heart rate of the recording (Frequency at which QRS complexes appear).
   The minimum and maximum heart rate, each with the time at which they happened.
2. Providing a possibility to set up the date and the time of the recording, as they are not included in the file. This should impact the date and the time seen in the measurements.

Cardiologs should be able to recover your work, understand it, trust it easily, maintain it, make changes to it, etc
You are free to choose any language/framework for this exercise.
