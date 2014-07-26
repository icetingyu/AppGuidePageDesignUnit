import bb.cascades 1.3

Page {
    property int currentLeftX
    property int touchDownX
    property int leftToRight
    property int downX;
    property double moveThreshold: ui.du(9)
    property int currentPage: 0
    property int howManyPages: 5
    property int displayWidth: ui.du(80)
    property int displayHeight: ui.du(80)
    
    Container {
        background: Color.Black
        ScrollView {
            id: scrollView
            scrollViewProperties.scrollMode: ScrollMode.Horizontal
            Container {
                layout: DockLayout {
                
                }
                ImageView {
                    preferredWidth: displayWidth * howManyPages
                    preferredHeight: displayHeight
                    imageSource: "asset:///images/allguides_q10_en.jpg"
                }
                Button {
                    translationX: ui.du(340)
                    translationY: ui.du(70)
                    id: closeBtn
                    text: "Enter"
                    onClicked: {
                        nav.pop();
                    
                    }
                }
            }
            
            onTouch: {
                if (event.isUp()) {
                    if (leftToRight == 0) {
                        if (currentPage+1 < howManyPages)
                        {
                            currentPage = currentPage+1;
                            scrollView.scrollToPoint(displayWidth*currentPage,0,ScrollAnimation.Smooth);
                        }
                    } else if (leftToRight == 1) {
                        if (currentPage-1 >=0)
                        {
                            currentPage = currentPage-1;
                            scrollView.scrollToPoint(displayWidth*currentPage,0,ScrollAnimation.Smooth);
                        }
                    } else {
                        scrollView.scrollToPoint(displayWidth*currentPage,0,ScrollAnimation.Smooth);
                    }
                    leftToRight = -1
                } else if (event.isMove()) {
                    if (event.windowX-downX < -moveThreshold) {
                        leftToRight = 0
                    } else if (event.windowX-downX > moveThreshold) {
                        leftToRight = 1
                    } else if (event.windowX-downX >= -moveThreshold && event.windowX-downX <= moveThreshold){
                        leftToRight = -1;
                    }
                } else if (event.isDown()) {
                    downX = event.windowX;
                    touchDownX = event.windowX+currentPage * displayWidth
                }
            }
        }
    }
}