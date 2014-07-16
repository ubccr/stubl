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
    <th>Peak (TFlop/s)</th>
    <th>Status  Load</th>
    <th>Active Jobs</th>
    <th>Queued Jobs</th>
    <th>Nodes Utilized</th>
    <th>Processors Utilized</th>
</tr>
<tr>
    <td>_MAXFLOPS_</td>
    <td>UP (_LOAD_%)</td>
    <td>_ACTIVEJOBS_</td>
    <td>_QUEUEDJOBS_</td>
    <td>_NODESINUSE_ of _NODESTOTAL_</td>
    <td>_CORESINUSE_ of _CORESTOTAL_</td>
</tr>
</table>

<br/>

<p>Summary of current jobs: </p>

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

<br/>

<p>Summary of current core usage:</p>

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


<br/>

<p>Summary of current node usage:</p>

<table class="ccr-dtable">
<tr>
    <th>Partition</th>
    <th>Used</th>
    <th>Unused</th>
</tr>

<!-- NODE SUMMARY -->

<tr><td>&nbsp;</td><td>_ALLNUSE_ (_PCTNUSE_%)</td><td>_ALLNUNU_ (_PCTNUNU_%)</td></tr>

</table>
