ExplanationsTab <- 
  tabItem("Explanation",
          # tags$head(
          #     # Note the wrapping of the string in HTML()
          #     tags$style(HTML(
          #     "tr {border-right: solid;border-width: 1px 0;}"))),
HTML(
  '
<div style="text-align:left;justify-content:center;margin-right:auto;margin-left:auto;">
<h2 style="text-align:center">Abbreviations of Solow Variants</h2>
<table style="margin-left:auto;margin-right:auto;">
<thead>
<tr>
<th align="center">&nbsp;&nbsp;&nbsp;Abbreviation &nbsp;&nbsp;&nbsp;</th>
<th align="left">Full Name of Solow Variant</th>
</tr>
</thead>
<tbody>
<tr>
<td align="center">BS</td>
<td align="left">Basic Solow Growth Model</td>
</tr>
<tr>
<td align="center">GS</td>
<td align="left">General Solow Growth Model</td>
</tr>
<tr>
<td align="center">ESHC</td>
<td align="left">Extended Solow Growth Model with Human Capital</td>
</tr>
<tr>
<td align="center">ESSOE</td>
<td align="left">Extended Solow Growth Model for the Small and Open Economy</td>
</tr>
<tr>
<td align="center">ESSRL</td>
<td align="left">Extended Solow Growth Model with Scarce Resource Land</td>
</tr>
<tr>
<td align="center">ESSRO</td>
<td align="left">Extended Solow Growth Model with Scarce Resource Oil</td>
</tr>
<tr>
<td align="center">ESSROL</td>
<td align="left">Extended Solow Growth Model with Scarce Resources Oil <em>and</em> Land</td>
</tr>
<tr>
<td align="center">ESEGRomer</td>
<td align="left">Extended Solow Growth Model with Endogenous Technological Growth by Romer</td>
</tr>
<tr>
<td align="center">ESEG</td>
<td align="left">Extended Solow Growth Model with Endogenous Technological Growth by Cozzi</td>
</tr>
</tbody>
</table>
<div style="height:20px"></div>
<h2 style="text-align:center">Abbreviations of Variables</h2>
<table style="margin-left:auto;margin-right:auto;">
<thead>
<tr>
<th>Full Variable Name</th>
<th align="center">&nbsp;&nbsp;&nbsp;Abbreviation&nbsp;&nbsp;&nbsp;</th>
</tr>
</thead>
<tbody>
<tr>
<td>Total Factor Productivity</td>
<td align="center">TFP</td>
</tr>
<tr>
<td>Labor Force</td>
<td align="center">L</td>
</tr>
<tr>
<td>(Physical) Capital</td>
<td align="center">K</td>
</tr>
<tr>
<td>Human Capital</td>
<td align="center">H</td>
</tr>
<tr>
<td>Consumption</td>
<td align="center">C</td>
</tr>
<tr>
<tr>
<td>Output</td>
<td align="center">Y</td>
</tr>
<tr>
<td>National Output</td>
<td align="center">Yn</td>
</tr>
<tr>
<td>National Savings</td>
<td align="center">Sn</td>
</tr>
<td>National Wealth</td>
<td align="center">V</td>
</tr>
<tr>
<td>Net Foreign Assets</td>
<td align="center">F</td>
</tr>
<tr>
<td>Energy</td>
<td align="center">E</td>
</tr>
<tr>
<td>Resource Stock (of Oil)</td>
<td align="center">R</td>
</tr>
<tr>
<td>Land</td>
<td align="center">X</td>
</tr>
<tr>
<td>Capital to Output Ratio</td>
<td align="center">CtO</td>
</tr>
<tr>
<td>Wage Rate</td>
<td align="center">WR</td>
</tr>
<tr>
<td>(Capital) Rental Rate</td>
<td align="center">RR</td>
</tr>
<tr>
<td>Land Rental Rate</td>
<td align="center">LR</td>
</tr>
</tbody>
</table>
<div style="height:20px"></div>
<h2 style="text-align:center">Prefixes and Suffixes</h2>
<table style="margin-left:auto;margin-right:auto;">
<thead>
<tr>
<th align="center">&nbsp;&nbsp;&nbsp;Prefix/Suffix &nbsp;&nbsp;&nbsp;</th>
<th>Meaning</th>
</tr>
</thead>
<tbody>
<tr>
<td align="center">gX</td>
<td>Growth Rate of X</td>
</tr>
<tr>
<td align="center">logX</td>
<td>Logarithm of X</td>
</tr>
<tr>
<td align="center">XpW</td>
<td>X per Worker</td>
</tr>
<tr>
<td align="center">XpEW</td>
<td>X per Effective Worker</td>
</tr>
</tbody>
</table>
<div style="height:20px"></div>
</div>')
  )