"""
Create a simple placeholder image for Bloom's Taxonomy Pyramid when the original image is not accessible.
This creates a simple colored pyramid image that can be used as a fallback.
"""

import os
from PIL import Image, ImageDraw, ImageFont

def create_bloom_pyramid_image(output_path, width=800, height=600):
    """Create a simple placeholder Bloom's Taxonomy Pyramid image"""
    try:
        # Create a white background
        img = Image.new('RGB', (width, height), color='white')
        draw = ImageDraw.Draw(img)
        
        # Define the pyramid shape
        pyramid = [
            (width//2, 50),  # Top point
            (width-100, height-50),  # Bottom right
            (100, height-50)  # Bottom left
        ]
        
        # Draw the pyramid outline
        draw.polygon(pyramid, outline='black', fill='lightblue')
        
        # Draw horizontal sections in the pyramid
        levels = 6  # Bloom's taxonomy has 6 levels
        for i in range(1, levels):
            y = 50 + (height-100) * i // levels
            draw.line([(100 + (width-200) * i / levels, y), 
                      (width - 100 - (width-200) * i / levels, y)], 
                      fill='black', width=2)
        
        # Add some text
        try:
            # Try to get a font
            font = ImageFont.truetype("arial.ttf", 20)
        except:
            # Fallback to default font
            font = ImageFont.load_default()
            
        draw.text((width//2-100, 20), "Bloom's Taxonomy Pyramid", fill='black', font=font)
        
        # Save the image
        img.save(output_path)
        return True
    except Exception as e:
        print(f"Error creating pyramid image: {str(e)}")
        return False

if __name__ == "__main__":
    output_path = os.path.join(os.path.dirname(os.path.abspath(__file__)), "bloom_pyramid_fallback.png")
    if create_bloom_pyramid_image(output_path):
        print(f"Created fallback pyramid image at {output_path}")
