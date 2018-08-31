
public class Main {

	public static void main(String[] args) {
		// TODO Auto-generated method stub

		//get shape factory
        AbstractFactory shapeFactory = FactoryProducer.getFactory(ShapeFactory.SHAPE);
        
        //get an object of Shape Circle
        Shape shape1 = shapeFactory.getShape(Circle.CIRCLE);
        
        //call draw method of Shape Circle
        shape1.draw();
        
        //get an object of Shape Rectangle
        Shape shape2 = shapeFactory.getShape(Rectangle.RECTANGLE);
        
        //call draw method of Shape Rectangle
        shape2.draw();
        
        //get an object of Shape Square
        Shape shape3 = shapeFactory.getShape(Square.SQUARE);
        
        //call draw method of Shape Square
        shape3.draw();
        
        
        //////////////////
        
        //get color factory
            AbstractFactory colorFactory = FactoryProducer.getFactory(ColorFactory.COLOR);
            
        //get an object of Color Blue
        Color color1 = colorFactory.getColor(Blue.BLUE);
        
        //call draw method of Color Blue
        color1.fill();
        
        //get an object of Color Green
        Color color2 = colorFactory.getColor(Green.GREEN);
        
        //call draw method of Color Green
        color2.fill();
        
        //get an object of Color Red
        Color color3 = colorFactory.getColor(Red.RED);
        
        //call draw method of Color Red
        color3.fill();
	}

}
