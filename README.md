## Nap Reservations

This is a spike to mimic a reservation system in production that has run into an
issue where future appointments are not reflected correctly when saved as UTC.

This will be built as closely to the production version as possible, while not
including many other areas of the app.  This spike will be unlike typical spikes
that may not have testing because I need to verify so many different appointment
scenarios, I need to automate this.  This is also a good opporunity to introduce
testing into franken-we-don't-need-no-tests ecosphere.  I will port the specs
here to the production app along with the solution.

*Current* reservation attributes of note and their datatypes:
- tour_date DateTime
- tour_time String

*Solution*
- format a tour_date by collecting desired date, including the tour_time string, and an offset of -10:00.
The Hawaiian timezone is safe to do this with because niether it nor UTC does daylight savings time.

All validations will be done against the "Hawaii" DateTime.
