#include "mainwindow.h"
#include "ui_mainwindow.h"

// add this line to project properties: qmake -project &&  qmake &&  mingw32-make

MainWindow::MainWindow(QWidget *parent) :
    QMainWindow(parent),
    ui(new Ui::MainWindow)
{
    ui->setupUi(this);
}

MainWindow::~MainWindow()
{
    delete ui;
}

void MainWindow::on_pushButton_clicked()
{
    ui->textEdit->append("I just clicked");
}
