<?php

namespace app\models;

use Yii;

/**
 * This is the model class for table "user".
 *
 * @property int $id
 * @property string|null $created_at
 * @property int|null $is_executor
 * @property float|null $raiting
 * @property string $email
 * @property string $name
 * @property string $password
 * @property string|null $avatar
 * @property string|null $date_of_birth
 * @property string|null $phone
 * @property string|null $telegram
 * @property int|null $city_id
 *
 * @property City $city
 * @property File[] $files
 * @property Response[] $responses
 * @property Task[] $tasks
 * @property Task[] $tasks0
 * @property UserCategory[] $userCategories
 */
class User extends \yii\db\ActiveRecord
{
    public $password_repeat;

    /**
     * {@inheritdoc}
     */
    public static function tableName()
    {
        return 'user';
    }

    /**
     * {@inheritdoc}
     */
    public function rules()
    {
        return [
            [['name', 'email', 'password', 'password_repeat', 'created_at', 'date_of_birth'], 'safe'],
            [['is_executor', 'city_id'], 'integer'],
            [['raiting'], 'number'],
            [['email', 'name', 'password', 'password_repeat'], 'required', 'message' => 'Это обязательное поле'],
            [['email', 'name', 'telegram'], 'string', 'max' => 64, 'message' => 'Максимальное количество символов 64'],
            [['name'], 'string', 'min' => 2, 'message' => 'Минимальное количество символов 2'],
            [['password'], 'string', 'max' => 60],
            [['password'], 'string', 'min' => 6, 'message' => 'Минимальное количество символов 6'],
            [['password'], 'compare'],
            [['avatar'], 'string', 'max' => 128, 'message' => 'Максимальное количество символов 128'],
            [['phone'], 'match', 'pattern' => '/^[\d]{11}/i', 'message' => 'Номер телефона должен состоять из 11 цифр'],
            [['email'], 'unique', 'message' => 'Пользователь с таким Email уже зарегистрирован'],
            [['city_id'], 'exist', 'skipOnError' => true, 'targetClass' => City::class, 'targetAttribute' => ['city_id' => 'id']],
        ];
    }

    /**
     * {@inheritdoc}
     */
    public function attributeLabels()
    {
        return [
            'id' => 'ID',
            'created_at' => 'Created At',
            'is_executor' => 'Я собираюсь откликаться на заказы',
            'raiting' => 'Рейтинг',
            'email' => 'Email',
            'name' => 'Ваше имя',
            'password' => 'Пароль',
            'avatar' => 'Аватар',
            'date_of_birth' => 'Дата рождения',
            'phone' => 'Телефон',
            'telegram' => 'Телеграм',
            'city_id' => 'City ID',
            'password_repeat' => 'Повтор пароля'
        ];
    }

    /**
     * Gets query for [[City]].
     *
     * @return \yii\db\ActiveQuery|CityQuery
     */
    public function getCity()
    {
        return $this->hasOne(City::class, ['id' => 'city_id']);
    }

    /**
     * Gets query for [[Files]].
     *
     * @return \yii\db\ActiveQuery|FileQuery
     */
    public function getFiles()
    {
        return $this->hasMany(File::class, ['user_id' => 'id']);
    }

    /**
     * Gets query for [[Responses]].
     *
     * @return \yii\db\ActiveQuery|ResponseQuery
     */
    public function getResponses()
    {
        return $this->hasMany(Response::class, ['user_id' => 'id']);
    }

    /**
     * Gets query for [[Tasks]].
     *
     * @return \yii\db\ActiveQuery|TaskQuery
     */
    public function getCustomerTasks()
    {
        return $this->hasMany(Task::class, ['customer_id' => 'id']);
    }

    /**
     * Gets query for [[Tasks0]].
     *
     * @return \yii\db\ActiveQuery|TaskQuery
     */
    public function getExecutorTasks()
    {
        return $this->hasMany(Task::class, ['executor_id' => 'id']);
    }

    /**
     * Gets query for [[UserCategories]].
     *
     * @return \yii\db\ActiveQuery|UserCategoryQuery
     */
    public function getUserCategories()
    {
        return $this->hasMany(UserCategory::class, ['user_id' => 'id']);
    }
}
