<!-- Code for Downtime maintainance Timer -->


<meta name="viewport" content="width=device-width, initial-scale=1.0">


<style>
body{
    text-align: center;
    background: #fff;
  font-family: sans-serif;
  font-weight: 100;
}
h1{
  color: #000000;
  font-weight: 100;
  font-size: 40px;
  margin: 40px 0px 20px;
}
 #clockdiv{
    font-family: sans-serif;
    color: #fff;
    display: inline-block;
    font-weight: 100;
    text-align: center;
    font-size: 20px;
}
#clockdiv > div{
    padding: 10px;
    border-radius: 3px;
    background: #666666;
    display: inline-block;
}
#clockdiv div > span{
    padding: 15px;
    border-radius: 3px;
    background: #666666;
    display: inline-block;
}
smalltext{
    padding-top: 2.5px;
    font-size: 5px;
	'width':390,
        'height':200
}
</style>

    
<!-- Countdwon timer -->

<b><p style="font-size:20px">Countdown to next maintenance downtime:</p></b>
<div id="clockdiv">
  <div>
    <span class="days" id="day"></span>
    <div class="smalltext">Days</div>
  </div>
  <div>
    <span class="hours" id="hour"></span>
    <div class="smalltext">Hours</div>
  </div>
  <div>
    <span class="minutes" id="minute"></span>
    <div class="smalltext">Minutes</div>
  </div>
  <div>
    <span class="seconds" id="second"></span>
    <div class="smalltext">Seconds</div>
  </div>
</div>

<p id="demo"></p>


<!-- Manually updating Countdown timer (remove tags and add tags for auto updating timer) -->

<!--


<script>

var deadline = new Date("jun 7, 2020 15:37:25").getTime();

var x = setInterval(function() {

var now = new Date().getTime();
var t = deadline - now;
var days = Math.floor(t / (1000 * 60 * 60 * 24));
var hours = Math.floor((t%(1000 * 60 * 60 * 24))/(1000 * 60 * 60));
var minutes = Math.floor((t % (1000 * 60 * 60)) / (1000 * 60));
var seconds = Math.floor((t % (1000 * 60)) / 1000);
document.getElementById("day").innerHTML =days ;
document.getElementById("hour").innerHTML =hours;
document.getElementById("minute").innerHTML = minutes;
document.getElementById("second").innerHTML =seconds;
if (t < 0) {
        clearInterval(x);
        document.getElementById("demo").innerHTML = "Downtime Maintainance in Progress...";
        document.getElementById("day").innerHTML ='0';
        document.getElementById("hour").innerHTML ='0';
        document.getElementById("minute").innerHTML ='0' ;
        document.getElementById("second").innerHTML = '0'; }
}, 1000);
</script>


-->

<!-- End of manually updating timer -->








<!-- Auto Updating downtime clock -->

<script>

var x = setInterval(function() {

var now = new Date();

var year = now.getFullYear();
var month = now.getMonth();
console.log(month)
var lastDay = [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31];
if (year % 4 === 0 && (year % 100 !== 0 || year % 400 === 0)) 
{
		lastDay[2] = 29;
}
var deadline = new Date()
deadline.setFullYear(year, month, lastDay[month]);
if((-deadline.getDay()-5)<=-7)
{
deadline.setDate(deadline.getDate() - deadline.getDay()-5+7)
}
else
{
deadline.setDate(deadline.getDate() - deadline.getDay()-5);
}
deadline.setHours(0,0,0,0);
//console.log(deadline)
if(now-deadline>=86400000)
{
	month=deadline.getMonth()+1;
	deadline.setFullYear(year, month, lastDay[month]);
	deadline.setDate(deadline.getDate() - deadline.getDay()-5);
	//console.log(deadline)
}

var t = deadline - now;
var days = Math.floor(t / (1000 * 60 * 60 * 24));
var hours = Math.floor((t%(1000 * 60 * 60 * 24))/(1000 * 60 * 60));
var minutes = Math.floor((t % (1000 * 60 * 60)) / (1000 * 60));
var seconds = Math.floor((t % (1000 * 60)) / 1000);
document.getElementById("day").innerHTML =days ;
document.getElementById("hour").innerHTML =hours;
document.getElementById("minute").innerHTML = minutes;
document.getElementById("second").innerHTML =seconds;
if (t < 0) {
        clearInterval(x);
        document.getElementById("demo").innerHTML = "Downtime Maintainance in Progress...";
        document.getElementById("day").innerHTML ='0';
        document.getElementById("hour").innerHTML ='0';
        document.getElementById("minute").innerHTML ='0' ;
        document.getElementById("second").innerHTML = '0'; }
}, 1000);
</script>




<!-- End of code for autoupdating Countdown Timer -->





<!-- Start of Doughnut Chart Script --->

    
    <script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>
    <script type="text/javascript">

      // Load Charts and the corechart package.
      google.charts.load('current', {'packages':['corechart']});

      // Draw the Doughnut 1 chart 
      google.charts.setOnLoadCallback(drawDoughnut1Chart);

      // Draw the Doughnut 2 chart
      google.charts.setOnLoadCallback(drawDoughnut2Chart);


     // Draw the Doughnut 3 chart
      google.charts.setOnLoadCallback(drawDoughnut3Chart); 
        
         
        
        // Callback to draw the doughnut chart
      function drawDoughnut1Chart() {

        // Create the data table for Doughnut 1 chart
           var data = google.visualization.arrayToDataTable([
          ['Task', 'Hours per Day'],
          ['Percentage Running',_PCTJRUN_],
          ['Percentage Queued', _PCTJQUE_]
        ]);

        // Set options for Doughnut 1 chart.
        var options = {
          title: 'Current job status(%):',
          pieHole: 0.4,
        colors: ['#005bbb', '#666666'],
	   'width':390,
        'height':200
        };

        // Instantiate and draw the Doughnut 1 Chart
        var chart = new google.visualization.PieChart(document.getElementById('Doughnut1'));
        chart.draw(data, options);
      }

      // Callback that draws the Doughnut 2 Chart
      function drawDoughnut2Chart() {

        // Create the data table for Doughnut 2 Chart
         var data = google.visualization.arrayToDataTable([
          ['Task', 'Hours per Day'],
          ['In Use', _PCTCUSE_],
          ['Unused',_PCTCUNU_ ]
        ]);

        // Set options for Doughnut 2 Chart
         var options = {
          title: 'Total Core Usage(%):',
          pieHole: 0.4,
        colors: ['#005bbb', '#666666'],
	'width':390,
        'height':200
        };

        // Instantiate and draw the Doughnut  Chart
        var chart = new google.visualization.PieChart(document.getElementById('Doughnut2'));
        chart.draw(data, options);
      }
        

                
        // Callback that draws the Doughnut 3 Chart
      function drawDoughnut3Chart() {

        // Create the data table for Doughnut 3 Chart
         var data = google.visualization.arrayToDataTable([
          ['Task', 'Hours per Day'],
          ['In Use', _PCTNUSE_],
          ['Unused',_PCTNUNU_]
        ]);

        // Set options for Doughnut 3 Chart
         var options = {
          title: 'Total Node Usage(%):',
          pieHole: 0.4,
            colors: ['#005bbb', '#666666'],
	'width':390,
         'height':200
        };

        // Instantiate and draw the Doughnut 3 Chart
        var chart = new google.visualization.PieChart(document.getElementById('Doughnut3'));
        chart.draw(data, options);
      }
        
        
    </script>

<!-- End Of Doughnut Chart Script -->
<!--end chart-->



<!-- saved from url=(0022)http://internet.e-mail -->
<div style="color:red">Last updated: _DATE_</div>
<style type="text/css">
.ccr-dtable {
    border-collapse: collapse;
}

.ccr-dtable td,th {
    border: 1px solid #ccc;
    padding: 3px;
}

.ccr-dtable th {
    background-color: #eee;
}

.ccr-dtable {
    text-align: right;
}
</style>

<table class="ccr-dtable">
<tr>
    <!--<th>Peak (TFlop/s)</th> -->
    <th>Status  Load</th>
    <th>Active Jobs</th>
    <th>Queued Jobs</th>
    <th>Nodes Utilized</th>
    <th>Processors Utilized</th>
   
</tr>
<tr>
   <!-- <td>_MAXFLOPS_</td> -->
    <td>UP (_LOAD_%)</td>
    <td>_ACTIVEJOBS_</td>
    <td>_QUEUEDJOBS_</td>
    <td>_NODESINUSE_ of _NODESTOTAL_</td>
    <td>_CORESINUSE_ of _CORESTOTAL_</td>
	
</tr>
</table>



<table class="columns">
    
<tr>
<td>
<br>    
    
    
<p align="left">Summary of current jobs: </p>

<table class="ccr-dtable">
<tr>
    <th>Partition</th>
    <th>Running</th>
    <th>Queued</th>
    <th>Total</th>
</tr>

<!-- JOB SUMMARY -->

<tr><td>&nbsp;</td><td>_ALLJRUN_ (_PCTJRUN_%)</td><td>_ALLJQUE_ (_PCTJQUE_%)</td><td>_ALLJTOT_</td></tr>

</table>
    </td>
<td><div id="Doughnut1" ></div></td>
    </tr>

    
<tr>
<td>
<br>
    
<p align="left">Summary of current core usage:</p>

<table class="ccr-dtable">
<tr>
    <th>Partition</th>
    <th>Total</th>
    <th>In Use</th>
    <th>Idle</th>
    <th>Other</th>
</tr>

<!-- CORE SUMMARY -->

<tr><td>&nbsp;</td><td>_ALLCTOT_</td><td>_ALLCUSE_ (_PCTCUSE_%)</td><td>_ALLCUNU_ (_PCTCUNU_%)</td><td>_ALLCOTH_</td></tr>

</table>
    </td>
<td><div id="Doughnut2" ></div></td>
    </tr>

    
<tr>
<td>
<br>    
    
    
<p align="left">Summary of current node usage:</p>

<table class="ccr-dtable">
<tr>
    <th>Partition</th>
    <th>Used</th>
    <th>Unused</th>
</tr>

<!-- NODE SUMMARY -->

 <tr><td>&nbsp;</td><td>_ALLNUSE_ (_PCTNUSE_%)</td><td>_ALLNUNU_ (_PCTNUNU_%)</td></tr>

</table>
    </td>
<td><div id="Doughnut3" ></div></td>
    </tr>
</table>

