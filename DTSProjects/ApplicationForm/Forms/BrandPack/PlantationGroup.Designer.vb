<Global.Microsoft.VisualBasic.CompilerServices.DesignerGenerated()> _
Partial Class PlantationGroup
    Inherits DTSProjects.BaseBigForm

    'Form overrides dispose to clean up the component list.
    <System.Diagnostics.DebuggerNonUserCode()> _
    Protected Overrides Sub Dispose(ByVal disposing As Boolean)
        If disposing AndAlso components IsNot Nothing Then
            components.Dispose()
        End If
        MyBase.Dispose(disposing)
    End Sub

    'Required by the Windows Form Designer
    Private components As System.ComponentModel.IContainer

    'NOTE: The following procedure is required by the Windows Form Designer
    'It can be modified using the Windows Form Designer.  
    'Do not modify it using the code editor.
    <System.Diagnostics.DebuggerStepThrough()> _
    Private Sub InitializeComponent()
        Dim resources As System.ComponentModel.ComponentResourceManager = New System.ComponentModel.ComponentResourceManager(GetType(PlantationGroup))
        Me.txtDescription = New System.Windows.Forms.TextBox
        Me.lblGroupID = New System.Windows.Forms.Label
        Me.Label1 = New System.Windows.Forms.Label
        Me.XpGradientPanel1 = New SteepValley.Windows.Forms.XPGradientPanel
        Me.Label4 = New System.Windows.Forms.Label
        Me.txtGroupName = New System.Windows.Forms.TextBox
        Me.Label3 = New System.Windows.Forms.Label
        Me.ListView1 = New System.Windows.Forms.ListView
        Me.colGroupID = New System.Windows.Forms.ColumnHeader
        Me.colGroupName = New System.Windows.Forms.ColumnHeader
        Me.colDescription = New System.Windows.Forms.ColumnHeader
        Me.Panel1 = New System.Windows.Forms.Panel
        Me.btnCancel = New Janus.Windows.EditControls.UIButton
        Me.btnOK = New Janus.Windows.EditControls.UIButton
        Me.txtSearchGroupName = New WatermarkTextBox.WaterMarkTextBox
        Me.XpGradientPanel1.SuspendLayout()
        Me.Panel1.SuspendLayout()
        Me.SuspendLayout()
        '
        'txtDescription
        '
        Me.txtDescription.Location = New System.Drawing.Point(81, 62)
        Me.txtDescription.Multiline = True
        Me.txtDescription.Name = "txtDescription"
        Me.txtDescription.Size = New System.Drawing.Size(336, 28)
        Me.txtDescription.TabIndex = 5
        '
        'lblGroupID
        '
        Me.lblGroupID.BackColor = System.Drawing.Color.Transparent
        Me.lblGroupID.BorderStyle = System.Windows.Forms.BorderStyle.Fixed3D
        Me.lblGroupID.Location = New System.Drawing.Point(82, 9)
        Me.lblGroupID.Name = "lblGroupID"
        Me.lblGroupID.Size = New System.Drawing.Size(107, 15)
        Me.lblGroupID.TabIndex = 2
        Me.lblGroupID.Text = "<<Autogenerated>>"
        '
        'Label1
        '
        Me.Label1.AutoSize = True
        Me.Label1.BackColor = System.Drawing.Color.Transparent
        Me.Label1.Location = New System.Drawing.Point(10, 9)
        Me.Label1.Name = "Label1"
        Me.Label1.Size = New System.Drawing.Size(65, 13)
        Me.Label1.TabIndex = 1
        Me.Label1.Text = "PlantationID"
        '
        'XpGradientPanel1
        '
        Me.XpGradientPanel1.Controls.Add(Me.Label4)
        Me.XpGradientPanel1.Controls.Add(Me.txtDescription)
        Me.XpGradientPanel1.Controls.Add(Me.txtGroupName)
        Me.XpGradientPanel1.Controls.Add(Me.Label3)
        Me.XpGradientPanel1.Controls.Add(Me.lblGroupID)
        Me.XpGradientPanel1.Controls.Add(Me.Label1)
        Me.XpGradientPanel1.Dock = System.Windows.Forms.DockStyle.Top
        Me.XpGradientPanel1.EndColor = System.Drawing.SystemColors.MenuBar
        Me.XpGradientPanel1.Location = New System.Drawing.Point(0, 0)
        Me.XpGradientPanel1.Name = "XpGradientPanel1"
        Me.XpGradientPanel1.Size = New System.Drawing.Size(425, 107)
        Me.XpGradientPanel1.StartColor = System.Drawing.Color.FromArgb(CType(CType(194, Byte), Integer), CType(CType(217, Byte), Integer), CType(CType(247, Byte), Integer))
        Me.XpGradientPanel1.TabIndex = 1
        '
        'Label4
        '
        Me.Label4.AutoSize = True
        Me.Label4.BackColor = System.Drawing.Color.Transparent
        Me.Label4.Location = New System.Drawing.Point(12, 65)
        Me.Label4.Name = "Label4"
        Me.Label4.Size = New System.Drawing.Size(60, 13)
        Me.Label4.TabIndex = 6
        Me.Label4.Text = "Description"
        '
        'txtGroupName
        '
        Me.txtGroupName.Location = New System.Drawing.Point(81, 36)
        Me.txtGroupName.Name = "txtGroupName"
        Me.txtGroupName.Size = New System.Drawing.Size(219, 20)
        Me.txtGroupName.TabIndex = 4
        '
        'Label3
        '
        Me.Label3.AutoSize = True
        Me.Label3.BackColor = System.Drawing.Color.Transparent
        Me.Label3.Location = New System.Drawing.Point(31, 36)
        Me.Label3.Name = "Label3"
        Me.Label3.Size = New System.Drawing.Size(35, 13)
        Me.Label3.TabIndex = 3
        Me.Label3.Text = "Name"
        '
        'ListView1
        '
        Me.ListView1.AllowColumnReorder = True
        Me.ListView1.Columns.AddRange(New System.Windows.Forms.ColumnHeader() {Me.colGroupID, Me.colGroupName, Me.colDescription})
        Me.ListView1.Dock = System.Windows.Forms.DockStyle.Fill
        Me.ListView1.FullRowSelect = True
        Me.ListView1.GridLines = True
        Me.ListView1.HideSelection = False
        Me.ListView1.Location = New System.Drawing.Point(0, 127)
        Me.ListView1.MultiSelect = False
        Me.ListView1.Name = "ListView1"
        Me.ListView1.Size = New System.Drawing.Size(425, 250)
        Me.ListView1.Sorting = System.Windows.Forms.SortOrder.Ascending
        Me.ListView1.TabIndex = 2
        Me.ListView1.UseCompatibleStateImageBehavior = False
        Me.ListView1.View = System.Windows.Forms.View.Details
        '
        'colGroupID
        '
        Me.colGroupID.Text = "GroupID"
        Me.colGroupID.Width = 86
        '
        'colGroupName
        '
        Me.colGroupName.Text = "Group Name"
        Me.colGroupName.Width = 130
        '
        'colDescription
        '
        Me.colDescription.Text = "Descriptions"
        Me.colDescription.Width = 186
        '
        'Panel1
        '
        Me.Panel1.BackColor = System.Drawing.Color.FromArgb(CType(CType(158, Byte), Integer), CType(CType(190, Byte), Integer), CType(CType(245, Byte), Integer))
        Me.Panel1.BorderStyle = System.Windows.Forms.BorderStyle.Fixed3D
        Me.Panel1.Controls.Add(Me.btnCancel)
        Me.Panel1.Controls.Add(Me.btnOK)
        Me.Panel1.Dock = System.Windows.Forms.DockStyle.Bottom
        Me.Panel1.Location = New System.Drawing.Point(0, 377)
        Me.Panel1.Name = "Panel1"
        Me.Panel1.Size = New System.Drawing.Size(425, 32)
        Me.Panel1.TabIndex = 3
        '
        'btnCancel
        '
        Me.btnCancel.DialogResult = System.Windows.Forms.DialogResult.Cancel
        Me.btnCancel.Location = New System.Drawing.Point(249, 3)
        Me.btnCancel.Name = "btnCancel"
        Me.btnCancel.Size = New System.Drawing.Size(67, 23)
        Me.btnCancel.TabIndex = 1
        Me.btnCancel.Text = "&Cancel"
        Me.btnCancel.VisualStyle = Janus.Windows.UI.VisualStyle.Office2007
        '
        'btnOK
        '
        Me.btnOK.DialogResult = System.Windows.Forms.DialogResult.OK
        Me.btnOK.Location = New System.Drawing.Point(334, 3)
        Me.btnOK.Name = "btnOK"
        Me.btnOK.Size = New System.Drawing.Size(67, 23)
        Me.btnOK.TabIndex = 0
        Me.btnOK.Text = "&OK"
        Me.btnOK.VisualStyle = Janus.Windows.UI.VisualStyle.Office2007
        '
        'txtSearchGroupName
        '
        Me.txtSearchGroupName.Dock = System.Windows.Forms.DockStyle.Top
        Me.txtSearchGroupName.Font = New System.Drawing.Font("Microsoft Sans Serif", 8.25!)
        Me.txtSearchGroupName.Location = New System.Drawing.Point(0, 107)
        Me.txtSearchGroupName.Name = "txtSearchGroupName"
        Me.txtSearchGroupName.Size = New System.Drawing.Size(425, 20)
        Me.txtSearchGroupName.TabIndex = 4
        Me.txtSearchGroupName.WaterMarkColor = System.Drawing.Color.Gray
        Me.txtSearchGroupName.WaterMarkText = "Enter Group Name to search, then press enter"
        '
        'PlantationGroup
        '
        Me.AcceptButton = Me.btnOK
        Me.AutoScaleDimensions = New System.Drawing.SizeF(6.0!, 13.0!)
        Me.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font
        Me.CancelButton = Me.btnCancel
        Me.ClientSize = New System.Drawing.Size(425, 409)
        Me.ControlBox = False
        Me.Controls.Add(Me.ListView1)
        Me.Controls.Add(Me.txtSearchGroupName)
        Me.Controls.Add(Me.Panel1)
        Me.Controls.Add(Me.XpGradientPanel1)
        Me.FormBorderStyle = System.Windows.Forms.FormBorderStyle.None
        Me.Icon = CType(resources.GetObject("$this.Icon"), System.Drawing.Icon)
        Me.Name = "PlantationGroup"
        Me.Text = "PlantationGroup"
        Me.XpGradientPanel1.ResumeLayout(False)
        Me.XpGradientPanel1.PerformLayout()
        Me.Panel1.ResumeLayout(False)
        Me.ResumeLayout(False)
        Me.PerformLayout()

    End Sub
    Private WithEvents Label4 As System.Windows.Forms.Label
    Private WithEvents Label3 As System.Windows.Forms.Label
    Private WithEvents txtDescription As System.Windows.Forms.TextBox
    Private WithEvents lblGroupID As System.Windows.Forms.Label
    Private WithEvents Label1 As System.Windows.Forms.Label
    Private WithEvents XpGradientPanel1 As SteepValley.Windows.Forms.XPGradientPanel
    Friend WithEvents ListView1 As System.Windows.Forms.ListView
    Private WithEvents colGroupID As System.Windows.Forms.ColumnHeader
    Private WithEvents colGroupName As System.Windows.Forms.ColumnHeader
    Private WithEvents colDescription As System.Windows.Forms.ColumnHeader
    Friend WithEvents Panel1 As System.Windows.Forms.Panel
    Private WithEvents txtSearchGroupName As WatermarkTextBox.WaterMarkTextBox
    Private WithEvents txtGroupName As System.Windows.Forms.TextBox
    Private WithEvents btnCancel As Janus.Windows.EditControls.UIButton
    Private WithEvents btnOK As Janus.Windows.EditControls.UIButton
End Class
