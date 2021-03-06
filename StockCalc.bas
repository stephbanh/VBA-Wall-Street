Attribute VB_Name = "Module1"
Sub stockCalcs():

' set up macro to loop through all worksheets

Dim ws As Worksheet

For Each ws In Worksheets

    ' set up column values
    Dim ticker_Name As String
    Dim yearly_Change, percent_Changed, total_Stock As Double
    
    ' Set variables for open, close, and volume
    Dim open_Val, close_Val, max_Val, min_Val, volume As Double

    ' Set counters for incrementing values
    Dim row_Counter As Integer
    row_Counter = 2

    Dim row_Helper As Integer
    row_Helper = 0

    Dim open_Counter As Double
    open_Counter = 2

    ' Set up last row
    last_Row = ws.Cells(Rows.Count, 1).End(xlUp).Row

    ' make the titles
    ws.Range("I1").Value = "Ticker"
    ws.Range("J1").Value = "Yearly Change"
    ws.Range("K1").Value = "Percent Changed"
    ws.Range("L1").Value = "Total Stock Volume"
    

    ' Loop through the rows of the worksheet
    For i = 2 To last_Row
    
        ' Check to see if there is a match; otherwise move down
        If ws.Cells(i + 1, 1).Value <> ws.Cells(i, 1).Value Then

        ' Set the values
        ticker_Name = ws.Cells(i, 1).Value
        open_Val = ws.Cells(open_Counter, 3).Value
        close_Val = ws.Cells(i, 6)
        volume = ws.Cells(i, 7)
      
        ' calculate values
        yearly_Change = close_Val - open_Val
        total_Stock = volume + total_Stock
      
        ' error handling for 0/0 outcome (PLNT)
        If open_Val = 0 And yearly_Change = 0 Then
            percent_Changed = 0
            
        ' error handling for a 0 start but accounting for growth from there
        ElseIf open_Val = 0 Then
            open_Val = 1
            percent_Changed = yearly_Change / open_Val
            percent_Changed = Format(percent_Changed, "Percent")
      
        Else
            percent_Changed = yearly_Change / open_Val
            percent_Changed = Format(percent_Changed, "Percent")
        End If

        ' Print the Name to the corresponding column
        ws.Range("I" & row_Counter).Value = ticker_Name
        ws.Range("J" & row_Counter).Value = yearly_Change
        ws.Range("K" & row_Counter).Value = percent_Changed
        ws.Range("L" & row_Counter).Value = total_Stock
      
        ' Add color formating, 4 is green, 3 is red
        If ws.Range("J" & row_Counter).Value > 0 Then
            ws.Range("J" & row_Counter).Interior.ColorIndex = 4
            
        Else
            ws.Range("J" & row_Counter).Interior.ColorIndex = 3
      
        End If

        ' Add to counters
        row_Counter = row_Counter + 1
        open_Counter = open_Counter + row_Helper + 1
      
        ' Reset values
        yearly_Change = 0
        percent_Changed = 0
        total_Stock = 0
        row_Helper = 0

        Else
            ' volume should be calculated here as it needs to accumulate
            volume = ws.Cells(i, 7)
            total_Stock = volume + total_Stock
            row_Helper = row_Helper + 1

    End If

    Next i
    
' bonus
    
Dim ticker1, ticker2, ticker3 As String
Dim max_Increase, max_Decrease, max_Volume As Double

last_Row2 = ws.Cells(Rows.Count, 11).End(xlUp).Row

'bonus titles
ws.Range("O1") = "Ticker"
ws.Range("P1") = "Value "
ws.Range("N2") = "Greatest % increase"
ws.Range("N3") = "Greatest % decrease"
ws.Range("N4") = "Greatest total volume"

    For j = 2 To last_Row2
    
        ' search for the corresponding value
        If ws.Cells(j, 12) > max_Volume Then
            max_Volume = ws.Cells(j, 12)
            ws.Range("P4").Value = max_Volume
            ticker1 = ws.Cells(j, 9)
            ws.Range("O4").Value = ticker1
        
        ElseIf ws.Cells(j, 11) > max_Increase Then
            max_Increase = ws.Cells(j, 11)
            ws.Range("P2").Value = Format(max_Increase, "0.00%")
            ticker2 = ws.Cells(j, 9)
            ws.Range("O2").Value = ticker2
            
        ElseIf ws.Cells(j, 11) < max_Decrease Then
            max_Decrease = ws.Cells(j, 11)
            ws.Range("P3").Value = Format(max_Decrease, "0.00%")
            ticker3 = ws.Cells(j, 9)
            ws.Range("O3").Value = ticker3
            
        End If
    

    Next j
    
    ' reset for next worksheet
    max_Increase = 0
    max_Decrease = 0
    max_Volume = 0

Next

End Sub
