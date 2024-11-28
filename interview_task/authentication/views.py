import json
from django.http import JsonResponse
from django.views.decorators.csrf import csrf_exempt
from .models import User
from .utils import verify_password, hash_password  # Ensure these utility functions are implemented

@csrf_exempt
def login(request):
    if request.method == 'POST':
        try:
            # Parse JSON body
            data = json.loads(request.body.decode('utf-8'))
            username = data.get('username')
            password = data.get('password')

            # Validate input
            if not username or not password:
                return JsonResponse({'error': 'Username and password are required'}, status=400)

            # Check if the user exists
            user = User.objects.filter(username=username).first()
            if user and verify_password(password, user.password):
                # Authentication successful
                return JsonResponse({'message': 'Login successful'}, status=200)
            else:
                return JsonResponse({'error': 'Invalid username or password'}, status=401)

        except json.JSONDecodeError:
            return JsonResponse({'error': 'Invalid JSON'}, status=400)
        except Exception as e:
            return JsonResponse({'error': f'Something went wrong: {str(e)}'}, status=500)

    return JsonResponse({'error': 'Invalid request method'}, status=405)


@csrf_exempt
def register(request):
    if request.method == 'POST':
        try:
            # Parse JSON body
            data = json.loads(request.body.decode('utf-8'))
            username = data.get('username')
            email = data.get('email')
            password = data.get('password')
            confirm_password = data.get('confirm_password')

            # Validate input
            if not username or not email or not password or not confirm_password:
                return JsonResponse({'error': 'All fields are required'}, status=400)

            if password != confirm_password:
                return JsonResponse({'error': 'Passwords do not match'}, status=400)

            # Check if username or email already exists
            if User.objects.filter(username=username).exists():
                return JsonResponse({'error': 'Username already taken'}, status=400)

            if User.objects.filter(email=email).exists():
                return JsonResponse({'error': 'Email already registered'}, status=400)

            # Save the user with hashed password
            hashed_password = hash_password(password)
            user = User(username=username, email=email, password=hashed_password)
            user.save()

            return JsonResponse({'message': 'User registered successfully'}, status=201)

        except json.JSONDecodeError:
            return JsonResponse({'error': 'Invalid JSON'}, status=400)
        except Exception as e:
            return JsonResponse({'error': f'Something went wrong: {str(e)}'}, status=500)

    return JsonResponse({'error': 'Invalid request method'}, status=405)
