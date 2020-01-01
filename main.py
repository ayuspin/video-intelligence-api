from google.cloud import videointelligence


def video_annotate(event):
    video_file_name = event.get('name')
    vide_file_bucket = event.get('bucket')
    input_uri = 'gs://' + vide_file_bucket + '/' + video_file_name
    output_uri = 'gs://' + vide_file_bucket + '/' + video_file_name + ".labels.json"
    video_client = videointelligence.VideoIntelligenceServiceClient()
    job = video_client.annotate_video(
        input_uri=input_uri,
        output_uri=output_uri,
        features=['LABEL_DETECTION'])

    print('Started label detection for {}'.format(video_file_name))

def store_labels(event):
    print('Storing lables from {}'.format(event.get('name')))

def main(event, context):
    if event.get('contentType')=='video/mp4':
        video_annotate(event)
    elif event.get('name').endswith('labels.json'):
        store_labels(event)
    else:
        print('Something went wrong. Here is {} Content-Type {}'.format(event.get('name'), event.get('contentType')))
