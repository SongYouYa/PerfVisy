import QtQuick 2.12
Canvas {
    id: canvas
    readonly property int internalArrowWidth: 50
    width: 600
    height: 180

    onPaint: {
        var context = getContext('2d');
        var ctx = canvas.getContext('2d');
        var gradient = ctx.createLinearGradient(0, 0, 0, height);
        gradient.addColorStop(0, "#2d8ada");
        gradient.addColorStop(0.34, "#1d80d8");
        gradient.addColorStop(1, "#0070d2")

        ctx.fillStyle = gradient;
        ctx.beginPath();
        ctx.moveTo(0, 0);
        ctx.lineTo(width - internalArrowWidth,0);
        ctx.lineTo(width, height / 2);
        ctx.lineTo(width - internalArrowWidth, height);
        ctx.lineTo(0, height);
        ctx.closePath();
        ctx.fill();
    }
}
