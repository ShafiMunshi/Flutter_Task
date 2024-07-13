# Project Summary
This is an assignment project from SoftBd

## Packages I used: 
|package name| reason to use   
|--|--|
| [get](https://pub.dev/packages/get)| for simple state management |
|[percent_indicator](https://pub.dev/packages/percent_indicator)|to create a rounded view of calculated passed days (1st screen)|
|[dio](https://pub.dev/packages/dio)  | for http network request handling  |
|[flutter_screenutil](https://pub.dev/packages/flutter_screenutil)|responsive design size management|
|[logger](https://pub.dev/packages/logger)|show log in a compact view
|[intl](https://pub.dev/packages/intl)|date-time management
|[flutter_svg](https://pub.dev/packages/flutter_svg)|showing svg in  apps
|[scrollable_positioned_list](https://pub.dev/packages/scrollable_positioned_list)|to use jump to today's date in scrollable listview (2nd screen )
||

## Coding design Pattern
Coding desgin pattern are used to separate all the business logic from UI and divide their works. for simplicity, I followed **MVC** ( Model-View-Controller) pattern. It's too easy and fun to work with it.  It divide all the logic into 3 parts 
 **Model** -> it works as middle man between database and UI. database could be a remote server or local server. 
 **View** -> It holds only application user interface part.
 **Controller** -> it holds all the functionality and the logic. It makes a surrounding connection with UI and Model. all functional works done here.
 ![Screenshot](https://lh3.googleusercontent.com/pw/AP1GczObcK30PVxSzIhktzJrPGpcb-FumPKsUVec0iPm6y9rY5zhmTYDRov3ccnANjtnta61Y5ZJpCESM-slfajPq_zQ4dYuP3wxfHM67nzHCmMhCORmLLwlHbJzoxCCduBxq8nUZGMOi4-WCRTSq2oIHastCA=w300-h470-s-no-gm)



##  Home Page Functionality

This is functional interface of home screen. 
![enter image description here](https://lh3.googleusercontent.com/pw/AP1GczOW0vUrKFuYsWftAgDYZ4w1cETGkPWqfAhrM_VYNv856zu-sVpMtWSbIqvFEBFAjFqXHTcg6wr8p-ufxR5j3xZGya7DbYAYu6Rv3YmntzS1jyvlgD-qKYE4Xo2-PHhPV19AmYiesvhvws2SKDXsS_6PHw=w864-h364-s-no-gm?authuser=0)

**Note:** 
I didn't use any Localization or pub packages to convert the Date and Time into Bengali Language. I made some custom function to convert  ->

 1.  english number to bengali number ( ১,২,৩,..)
 2.  english month to bengali month  (জানুয়ারি, ফেব্রুয়ারি..)
 3.  english week-day to bengali week-day ( শনি, রবি, সোম ..)
 4. get actual Day-break time ( সকাল, বিকাল, রাত)
please, have a look on this [custom function code](https://github.com/ShafiMunshi/Flutter_Task/blob/main/lib/src/screen/widgets/global_widget.dart) , 

**Calculated Total time passed from 01 January,2024 to Today:**

    String  getPassedDaysString() {
	    final  firstDate  =  DateTime(2024, 1, 1);
	    final  today  =  DateTime.now();
	    
	    String  data  =  '';
	    int  passedDays  = today.difference(firstDate).inDays; // get total passed days from
	    int  passedYear  = (passedDays  /  365).floor();
	    if (passedYear  >  0) {
		    data  +=  "${convertNumsToBengali(passedYear.toString())} বছর ";
		    passedDays  =  passedDays  - (passedYear  *  365);    
	    }
	    int  passedMonth  = (passedDays  / 30).floor();
	    if (passedMonth  >  0) {
		    data  +=  "${convertNumsToBengali(passedMonth.toString())} মাস ";
		    passedDays  =  passedDays  - (passedMonth  *  30);
	    }
	    data  +=  "${convertNumsToBengali(passedDays.toString())} দিন";
	    return  data;
    }
    
    //it will return =>  ৬ মাস ১৪ দিন 
**Calculated Total time remains from Today to 31 December, 2030:**
for acquirate remaining days calculation we have consider the leap year, 
day count of a year = 365 days
but a leap year = 366 days, and this year comes after every 4 years. 
So, the approximate days of every year is = 365 + ( 1 / 4 ) = 365.25

    String  getRemainingDays() {
	    final  now  =  DateTime.now();
	    final  targetDate  =  DateTime(2030, 1, 31);
	    final  difference  =  targetDate.difference(now);
	    
	    int  totalDays  =  difference.inDays;
	   
	    int  years  =  0;
	    
	    // checking leap year and removes the day of according to that year
	    while (totalDays  >=  365  + (isLeapYear(now.year  +  years) ?  1  :  0)) {
		    totalDays  -=  365  + (isLeapYear(now.year  +  years) ?  1  :  0);
		    years++;
	    }
	    
	     // Approximate average days per month
	    const  averageDaysPerMonth  =  365.25  /  12;
	    
	    int  months  = (totalDays  /  averageDaysPerMonth).floor();
	    int  days  =  totalDays  - (months  *  averageDaysPerMonth).round();
	    
	    print('Years: $years');
	    print('Months: $months');
	    print('Days: $days');
		
		// converting to them into bengali language
	    String  data  =  '';
	    if (years  >  0) {
		    if (years  >  9) {
			    data  +=  "${convertNumsToBengali(years.toString())}";
		    } else {
			    data  +=  "০${convertNumsToBengali(years.toString())}";
		    }
	    }
	    if (months  >  0) {
		    if (months  >  9) {
			    data  +=  "${convertNumsToBengali(months.toString())}";
		    } else {
			    data  +=  "০${convertNumsToBengali(months.toString())}";
		    }
	    }
	    if (days  >  9) {
		    data  +=  "${convertNumsToBengali(days.toString())}";
	    } else {
		    data  +=  "০${convertNumsToBengali(days.toString())}";
	    }
	    
	    return  data;
    } // ০৫০৬১৭ --> this is how it will return ( 5 year 6 month 17 days) 
    
    bool  isLeapYear(int  year) {
	    return (year  %  4  ==  0) && ((year  %  100  !=  0) || (year  %  400  ==  0));
    }

##  Calendar Screen Functionality

At first talking about this scrollable list of date 
![scrollable date list ](https://lh3.googleusercontent.com/pw/AP1GczPMB2i1eW_qeeYk2nE9_MhZqpMB7pFg5_-gJKHUf88Z-Vwmfx2llIQF5JJKQhu7NCW-Wi_h2EM5JJgWpj4B7JgqbCtLbRy9eHLvaeSwwW02XE3L1BR3eaqO0Nkvai4X3SMA3h6wLzLtuZ4Gq1mrC-uxgw=w864-h394-s-no-gm?authuser=0)

 **generate previous 7 days and future 7 days function**

    List<DateTime> getAllWeekends() {
    
	    List<DateTime> lists  = [];
	    DateTime  curDateTime  =  DateTime.now();
	    lists.add(curDateTime);
	    
	    // get the previous 7 days from today
	    for (var  i  =  0; i  <  7; i++) {
		    curDateTime  =  curDateTime.subtract(Duration(days:  1));
		    lists.insert(0, curDateTime);
	    }
	    
	    curDateTime  =  DateTime.now();
	    // add the future 7 days
	    for (var  i  =  0; i  <  7; i++) {
		    curDateTime  =  curDateTime.add(Duration(days:  1));
		    lists.add(curDateTime);
	    }
	    
	    return  lists;
    }

using custom function for converting the date-time in bengali helps me show the date-time related stuff in  bengali language.



#### Sending request on API and updating the state
I created a template form many coders which really helps me to call http server.  [here it is.](https://github.com/ShafiMunshi/Flutter_Task/blob/main/lib/src/data/remote/dio_call.dart)

    Future<void> getAllQuotes() async {
	    await  BaseClient.safeApiCall(AppUrl.api_endpoint, RequestType.get,
	    onLoading: () {
		    isDataLoading  =  true;
		    update();
	    }, onSuccess: (response) {
		    allQuotes  =  quotesModelFromJson(response.toString());

			// sorting the list data according to most neighbor date
      		data.sort((a, b) => b.date.compareTo(a.date));
	   
	    }, onError: (error) {
		    CustomSnackBar.showCustomErrorToast(message:  error.message);
	    });
	    isDataLoading  =  false;
	    update();
    }
This is how Qoutes image list look like
![list image](https://lh3.googleusercontent.com/pw/AP1GczOLnqNNT6Eh6qfABCfaJ37LeTNDAz-9_CgY8E_cswwx0eS4iDZhJygSXhXFCxpxoGKUjS22Np2u2zhxNY84YYZpDHmx9HaHeaJuMDhk4fH0IVxYKfvVEUqN1WPG7DY5fmHPuIfomr1TpEbcr3qSePBTWQ=w864-h332-s-no-gm?authuser=0)


## New Data Entry Screen
![Image screen shot](https://lh3.googleusercontent.com/pw/AP1GczOBI51VRuYlR8CkNb79WWsfvom03bOzq5JGI828UzrIb9S-J4712n0XqLi-tCgrW97T-rD9YF2F6ahMBqqkwgVfBKd1v_fcNZvVLV2QTJkvu3yThlSydPypMKX0rUg2bfnm-rsPrnTVmFyI0Pf_fvkfjQ=w437-h971-s-no-gm?authuser=0)
**Screen Functionality:**

 - change word count when user type 
 - show the date-time in bengali 
 - language Handle Error Validation TextField & DropDown button

 ### Click to save into the all Sentence in Descending Order of Date-Time
 

