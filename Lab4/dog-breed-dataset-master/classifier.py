import turicreate as turi
import os

data = turi.image_analysis.load_images('training', with_path=True)
data['label'] = data['path'].apply(lambda path: os.path.basename(os.path.dirname(path)))
data.save('image-classifier.sframe')

data = turi.SFrame('image-classifier.sframe')
testing, training = data.random_split(0.8)
classifier = turi.image_classifier.create(training, target='label', model='resnet-50')

result = classifier.evaluate(testing)
print(result['accuracy'])

classifier.save('image-classifier.model')
classifier.export_coreml('image-classifier.mlmodel')
